import 'package:redux_saga/redux_saga.dart';

Runnable take<Selector, ActionType>(Selector selector, [RunnableCallback<ActionType> callback]) {
  return _Take(selector, callback);
}

class _Take<Selector, ActionType> extends Runnable {
  final Selector selector;
  final RunnableCallback<ActionType> callback;
  _Take(this.selector, this.callback);

  @override
  RunnableStatus run(SagaManager sagaManager) {
    return null;
  }
}
