import 'package:redux_saga/redux_saga.dart';

class Task extends Runnable {
  final Iterator<Runnable> _runnables;

  Runnable _last;

  Task(this._runnables);

  @override
  RunnableStatus run(SagaManager sagaManager) {
    if (_last == null) {
      _last = _next();
    }

    RunnableStatus status = RunnableStatus.Done;

    while (_last != null) {
      RunnableStatus currentStatus = _last.run(sagaManager);
      switch (currentStatus) {
        case RunnableStatus.Done:
          _last = _next();
          break;
        case RunnableStatus.Waiting:
          if(this.parallel) {
            status = RunnableStatus.Waiting;
            _last = _next();
          } else {
            return RunnableStatus.Waiting;
          }
      }
    }

    return status;
  }

  bool get parallel {
    return false;
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


