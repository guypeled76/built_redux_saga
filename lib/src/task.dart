import 'package:redux_saga/redux_saga.dart';

class Task extends Runnable {
  Iterator<Runnable> _runnables;

  bool _parallel;

  Runnable _last;

  Task(this._runnables, this._parallel);

  @override
  RunnableStatus run(SagaManager sagaManager) {
    if (_last == null) {
      _last = _next();
    }

    RunnableStatus status = RunnableStatus.Done;

    var residuals = <Runnable>[];

    while (_last != null) {
      RunnableStatus currentStatus = _last.run(sagaManager);
      switch (currentStatus) {
        case RunnableStatus.Done:
          _last = _next();
          break;
        case RunnableStatus.Canceled:
          if(this._parallel) {
            _last = _next();
          } else {
            return RunnableStatus.Canceled;
          }
          break;
        case RunnableStatus.Failed:
          if(this._parallel) {
            _last = _next();
          } else {
            return RunnableStatus.Failed;
          }
          break;
        case RunnableStatus.Waiting:
          if(this._parallel) {
            status = RunnableStatus.Waiting;
            residuals.add(_last);
            _last = _next();
          } else {
            return RunnableStatus.Waiting;
          }
      }
    }

    if(this._parallel) {
      _runnables = residuals.iterator;
    }

    return status;
  }

  Runnable _next() {
    if (_runnables == null) {
      return null;
    }
    if (_runnables.moveNext()) {
      return _runnables.current;
    } else {
      return null;
    }
  }
}



