import 'package:redux_saga/redux_saga.dart';

class _Call<ValueType> extends RunnableFuture {
  final Future<ValueType> _future;

  

  _Call(this._future, [RunnableCallback<ValueType> _success, RunnableCallback _error]) : super(_success, _error){
    this._future.then(this.successHandler).catchError(this.errorHandler);
  }
}



Runnable call<ValueType>(Future<ValueType> future, [RunnableCallback<ValueType> callback, RunnableCallback error]) {
  return _Call(future, callback, error);
}