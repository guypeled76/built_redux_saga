import 'package:built_redux_saga/built_redux_saga.dart';

class Task extends Runnable {
  Iterator<Runnable> _runnables;

  bool _parallel;

  bool _canceled = false;

  Runnable _last;

  Task(this._runnables, this._parallel);

  @override
  RunnableStatus run(SagaMiddlewareManager sagaManager) {
    if (_last == null) {
      _last = _next();
    }

    RunnableStatus status = RunnableStatus.Done;

    if(!_canceled) {
      var residuals = <Runnable>[];

      while (_last != null) {
        forkIfNeeded();
        
        RunnableStatus currentStatus = _last.run(sagaManager);
        switch (currentStatus) {
          case RunnableStatus.Done:
            _last = _next();
            break;
          case RunnableStatus.Canceled:
            if (this._parallel) {
              _last = _next();
            } else {
              return RunnableStatus.Canceled;
            }
            break;
          case RunnableStatus.Failed:
            if (this._parallel) {
              _last = _next();
            } else {
              return RunnableStatus.Failed;
            }
            break;
          case RunnableStatus.Waiting:
            if (this._parallel) {
              status = RunnableStatus.Waiting;
              residuals.add(_last);
              _last = _next();
            } else {
              return RunnableStatus.Waiting;
            }
        }
      }

      if (this._parallel) {
        _runnables = residuals.iterator;
      }
    } else {
      status = RunnableStatus.Canceled;
    }

    return status;
  }

  void forkIfNeeded() {
    if(_last is ForkTask) {
      ForkTask forkTask = _last as ForkTask;
      if (forkTask != null) {
        // Run the rest of the runnables in parallel to the fork task
        _last = ForkTask(
            <Runnable>[Task(this._runnables, this._parallel), forkTask]);

        // The rest of the runnables where moved to the forking task
        this._runnables = <Runnable>[].iterator;
      }
    }
  }

  void cancel() {
    _canceled = true;
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


class ForkTask extends Task {
  ForkTask(Iterable<Runnable> runnable) : super(runnable.iterator, true);
}



