import 'package:redux_saga/redux_saga.dart';

class _Call<ValueType> extends Runnable {
  final Future<ValueType> value;
  final RunnableCallback<ValueType> callback;

  _Call(this.value, this.callback);

  @override
  RunnableStatus run(SagaManager sagaManager) {
    return RunnableStatus.Waiting;
  }

}



Runnable call<ValueType>(Future<ValueType> future, [RunnableCallback<ValueType> callback]) {
  return _Call(future, callback);
}