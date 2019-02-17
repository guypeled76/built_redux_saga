import 'package:redux_saga/redux_saga.dart';
import 'package:built_redux/built_redux.dart';

Runnable take<PayloadType>(ActionName<PayloadType> actionName, [RunnableCallback<Action<PayloadType>> success, RunnableCallback error]) {
  return _Take(actionName, success, error);
}

class _Take<PayloadType> extends RunnableFuture<Action<PayloadType>> {
  final ActionName<PayloadType> actionName;
  _Take(this.actionName, RunnableCallback<Action<PayloadType>> success, RunnableCallback error) : super(success, error);

  @override
  void initHandler(SagaMiddlewareManager sagaManager) {
    super.initHandler(sagaManager);
    sagaManager.take(actionName).then(this.successHandler).catchError(this.errorHandler);
  }
}
