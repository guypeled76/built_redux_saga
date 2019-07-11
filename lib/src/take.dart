import 'package:built_redux_saga/built_redux_saga.dart';
import 'package:built_redux/built_redux.dart';



Runnable take<PayloadType>(ActionName<PayloadType> actionName, [Result<Action<PayloadType>> result]) {
  return _Take(actionName, result?.onSuccess, result?.onError);
}

class _Take<PayloadType> extends RunnableFuture<Action<PayloadType>> {
  final ActionName<PayloadType> actionName;
  _Take(this.actionName, RunnableCallback<Action<PayloadType>> success, RunnableCallback<Error> error) : super(success, error);

  @override
  void initHandler(SagaMiddlewareManager sagaManager) {
    super.initHandler(sagaManager);
    sagaManager.take(actionName).then(this.successHandler).catchError(this.errorHandler);
  }
}

Runnable takeEverything([Result result]) {
  return _TakeEverything(result?.onSuccess, result?.onError);
}


class _TakeEverything extends RunnableFuture<Action<Object>> {
  _TakeEverything(RunnableCallback<Action<Object>> success, RunnableCallback<Error> error) : super(success, error);

  @override
  void initHandler(SagaMiddlewareManager sagaManager) {
    super.initHandler(sagaManager);
    sagaManager.takeEverything().then(this.successHandler).catchError(this.errorHandler);
  }
}