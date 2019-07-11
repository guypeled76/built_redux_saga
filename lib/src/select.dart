import 'package:built_redux_saga/built_redux_saga.dart';

class _Select<ResultType> extends Runnable {

  final RunnableCallback<ResultType> callback;
  _Select(this.callback);

  @override
  RunnableStatus run(SagaMiddlewareManager sagaManager) {
    this.callback(sagaManager.select<ResultType>());
    return RunnableStatus.Done;
  }


}

Runnable select<ResultType>(Result<ResultType> result) {
  return _Select(result.onSuccess);
}