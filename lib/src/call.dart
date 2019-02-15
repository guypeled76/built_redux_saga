import 'package:redux_saga/redux_saga.dart';

class _Call<ValueType> extends Runnable {
  final Future<ValueType> _future;
  final RunnableCallback<ValueType> _success;
  final RunnableCallback<ValueType> _error;
  
  RunnableStatus _status = RunnableStatus.Waiting;

  _Call(this._future, [this._success, this._error]) {
    this._future.then((value) {
      this._status = RunnableStatus.Done;
      if(this._success != null) {
        this._success(value);
      }
    }).catchError((error) {
      this._status = RunnableStatus.Done;
      if(this._error != null) {
        this._error(error);
      }
    });
  }

  @override
  RunnableStatus run(SagaManager sagaManager) {
    return this._status;
  }
}



Runnable call<ValueType>(Future<ValueType> future, [RunnableCallback<ValueType> callback, RunnableCallback<ValueType> error]) {
  return _Call(future, callback, error);
}