import 'package:built_redux/built_redux.dart';
import 'package:redux_saga/redux_saga.dart';

Runnable put<PayloadType>(ActionName<PayloadType> actionName,PayloadType payload) {
  return _Put(actionName, payload);
}

class _Put<PayloadType> extends Runnable {
  final ActionName<PayloadType> actionName;
  final PayloadType payload;
  _Put(this.actionName, this.payload);

  @override
  RunnableStatus run(SagaMiddlewareManager sagaManager) {
    sagaManager.put(this.actionName, this.payload);
    return RunnableStatus.Done;
  }
}
