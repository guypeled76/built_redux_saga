import 'package:redux_saga/redux_saga.dart';

abstract class Runnable {
  RunnableStatus run(SagaManager sagaManager);

  static Iterator<Runnable> createTasksFromList(List<Iterable<Runnable>> runnableList) {
    return runnableList.map((runnable) => Task(runnable.iterator, false)).toList().iterator;
  }
}

abstract class RunnableFuture extends Runnable {

  RunnableStatus _status = RunnableStatus.Waiting;

  SagaManager _sagaManager;


  void done() {
    _status = RunnableStatus.Done;
    if(_sagaManager != null) {
      _sagaManager.run();
    }
  }

  @override
  RunnableStatus run(SagaManager sagaManager) {
    _sagaManager = sagaManager;
    return this._status;
  }

}

enum RunnableStatus {
  Waiting,
  Done
}

typedef void RunnableCallback<ValueType>(ValueType value);