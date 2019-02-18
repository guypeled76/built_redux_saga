import 'package:built_redux_saga/built_redux_saga.dart';

Runnable register<Type>(Type instance) {
  return _Register<Type>(instance);
}

class _Register<Type> extends Runnable {
  final Type instance;
  _Register(this.instance);

  @override
  RunnableStatus run(SagaMiddlewareManager sagaManager) {
    sagaManager.register<Type>(() => this.instance);
    return RunnableStatus.Done;
  }
}

typedef Type RegisteredItemFactory<Type>();
