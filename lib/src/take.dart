import 'package:redux_saga/redux_saga.dart';

Runnable take<Selector, ActionType>(Selector selector, [RunnableCallback<ActionType> success, RunnableCallback error]) {
  return _Take(selector, success, error);
}

class _Take<Selector, ActionType> extends RunnableFuture<ActionType> {
  final Selector selector;
  _Take(this.selector, RunnableCallback<ActionType> success, RunnableCallback error) : super(success, error);

  @override
  void initHandler(SagaManager sagaManager) {
    super.initHandler(sagaManager);
    sagaManager.take(selector).then(this.successHandler).catchError(this.errorHandler);
  }
}
