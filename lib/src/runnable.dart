import 'package:redux_saga/redux_saga.dart';

abstract class Runnable {
  RunnableStatus run(SagaManager sagaManager);

  static Iterator<Runnable> createTasksFromList(List<Iterable<Runnable>> runnableList) {
    return runnableList.map((runnable) => Task(runnable.iterator, false)).toList().iterator;
  }
}

abstract class RunnableFuture<ValueType> extends Runnable {

  final RunnableCallback<ValueType> _success;
  final RunnableCallback<ValueType> _error;

  RunnableStatus _status = RunnableStatus.Waiting;
  SagaManager _sagaManager;

  RunnableFuture(this._success, this._error);

  void successHandler(ValueType value) {
    if(this._success != null) {
      this._success(value);
    }
    _status = RunnableStatus.Done;
    if(_sagaManager != null) {
      _sagaManager.run();
    }
  }

  void errorHandler(error) {
    if(this._error != null) {
      this._error(error);
    }
    _status = RunnableStatus.Failed;
    if(_sagaManager != null) {
      _sagaManager.run();
    }
  }

  @override
  RunnableStatus run(SagaManager sagaManager) {
    if(_sagaManager == null) {
      _sagaManager = sagaManager;
      initHandler(sagaManager);
    }
    return this._status;
  }

  void initHandler(SagaManager sagaManager) {

  }

}

enum RunnableStatus {
  Failed,
  Canceled,
  Waiting,
  Done
}

typedef void RunnableCallback<ValueType>(ValueType value);