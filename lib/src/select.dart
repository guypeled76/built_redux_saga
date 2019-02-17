import 'package:built_redux_saga/built_redux_saga.dart';

class _Select<SelectorType, ValueType> extends Runnable {
  final SelectorType selector;
  final RunnableCallback<ValueType> callback;
  _Select(this.selector, this.callback);

  @override
  RunnableStatus run(SagaMiddlewareManager sagaManager) {
    this.callback(sagaManager.select<SelectorType, ValueType>(this.selector));
    return RunnableStatus.Done;
  }


}

Runnable select<SelectorType, ValueType>(SelectorType selector, RunnableCallback<ValueType> callback) {
  return _Select(selector, callback);
}