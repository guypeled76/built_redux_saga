import 'package:redux_saga/redux_saga.dart';

class _Call<ValueType> extends Runnable {
  final Future<ValueType> future;
  final RunnableCallback<ValueType> success;
  final RunnableCallback<ValueType> error;
  
  RunnableStatus _status = RunnableStatus.Waiting;

  _Call(this.future, [this.success, this.error]) {
    this.future.then((value) {
      this._status = RunnableStatus.Done;
      if(this.success != null) {
        this.success(value);
      }
    }).catchError((error) {
      this._status = RunnableStatus.Done;
      if(this.error != null) {
        this.error(error);
      }
    });
  }

  @override
  RunnableStatus run(SagaManager sagaManager) {
    return this._status;
  }

}



Runnable call<ValueType>(Future<ValueType> future, [RunnableCallback<ValueType> callback]) {
  return _Call(future, callback);
}