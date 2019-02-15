import 'package:redux_saga/redux_saga.dart';

Runnable put<T>(T action) {
  return _Put(action);
}

class _Put<Action> extends Runnable {
  final Action action;
  _Put(this.action);

  @override
  RunnableStatus run(SagaManager sagaManager) {
    sagaManager.put(this.action);
    return RunnableStatus.Done;
  }
}
