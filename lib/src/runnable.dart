import 'package:built_redux_saga/built_redux_saga.dart';

abstract class Runnable {
  RunnableStatus run(SagaMiddlewareManager sagaManager);

  static Iterator<Runnable> createTasksFromList(List<Iterable<Runnable>> runnableList) {
    return runnableList.map((runnable) => Task(runnable.iterator, false)).toList().iterator;
  }
}

abstract class RunnableFuture<ValueType> extends Runnable {

  final RunnableCallback<ValueType> _success;
  final RunnableErrorHandler _error;

  RunnableStatus _status = RunnableStatus.Waiting;
  SagaMiddlewareManager _sagaManager;

  RunnableFuture(this._success, this._error);
  
  get errorMessage;

  void successHandler(ValueType value) {
    if(this._success != null) {
      this._success(value);
    }
    _status = RunnableStatus.Done;
    if(_sagaManager != null) {
      _sagaManager.run();
    }
  }

  void errorHandler(error, stacktrace) {
    if(this._error != null) {
      try {
        this._error(RunnableError(this.errorMessage, error, stacktrace));
      } catch(e) {
        _sagaManager.fatalError(e);
      }
    }

    _status = RunnableStatus.Failed;
    if(_sagaManager != null) {
      _sagaManager.run();
    }
  }

  @override
  RunnableStatus run(SagaMiddlewareManager sagaManager) {
    if(_sagaManager == null) {
      _sagaManager = sagaManager;
      initHandler(sagaManager);
    }
    return this._status;
  }

  void initHandler(SagaMiddlewareManager sagaManager) {

  }

}

enum RunnableStatus {
  Failed,
  Canceled,
  Waiting,
  Done
}

typedef void RunnableCallback<ValueType>(ValueType value);

typedef void RunnableErrorHandler(RunnableError error);