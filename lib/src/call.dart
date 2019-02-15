import 'package:redux_saga/redux_saga.dart';

class _Call<ValueType> extends RunnableFuture {
  final Future<ValueType> _future;
  final RunnableCallback<ValueType> _success;
  final RunnableCallback<ValueType> _error;
  

  _Call(this._future, [this._success, this._error]) {
    this._future.then((value) {
      if(this._success != null) {
        this._success(value);
      }
      this.done();
    }).catchError((error) {
      if(this._error != null) {
        this._error(error);
      }
      this.done();
    });
  }
}



Runnable call<ValueType>(Future<ValueType> future, [RunnableCallback<ValueType> callback, RunnableCallback<ValueType> error]) {
  return _Call(future, callback, error);
}