import 'package:redux_saga/redux_saga.dart';
import 'package:built_redux/built_redux.dart';

Runnable take<PayloadType>(ActionName<PayloadType> selector, [RunnableCallback<Action<PayloadType>> success, RunnableCallback error]) {
  return _Take(selector, success, error);
}

class _Take<PayloadType> extends RunnableFuture<Action<PayloadType>> {
  final ActionName<PayloadType> selector;
  _Take(this.selector, RunnableCallback<Action<PayloadType>> success, RunnableCallback error) : super(success, error);

  @override
  void initHandler(SagaMiddlewareManager sagaManager) {
    super.initHandler(sagaManager);
    sagaManager.take(selector).then(this.successHandler).catchError(this.errorHandler);
  }
}
