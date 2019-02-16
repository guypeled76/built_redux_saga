import 'package:redux_saga/redux_saga.dart';
import 'dart:collection';

class ProcessTask extends Task {

  final Queue<_process> _processes = new Queue();

  bool _running = false;


  RunnableStatus _status = RunnableStatus.Done;


  ProcessTask(Iterator<Runnable> runnables) : super(runnables, true);

  @override
  RunnableStatus run(SagaMiddlewareManager sagaManager) {
    _processes.add(() => super.run(sagaManager));

    if(!_running) {
      try {
        _running = true;

        while (_processes.isNotEmpty) {
          _status = RunnableStatus.Waiting;
          _status = _processes.removeFirst()();
        }
      } finally {
        _running = false;
      }
    }
    return _status;
  }

  RunnableStatus get status {
    return this._status;
  }
}


typedef RunnableStatus _process();