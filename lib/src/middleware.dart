import 'package:built_redux/built_redux.dart';
import 'package:built_redux_saga/built_redux_saga.dart';
import 'package:built_value/built_value.dart';

Middleware<StateType, StateBuilderType, ActionsType> createSagaMiddleware<
    StateType extends Built<StateType, StateBuilderType>,
    StateBuilderType extends Builder<StateType, StateBuilderType>,
    ActionsType extends ReduxActions>(List<Iterable<Runnable>> runnableList) {
  SagaMiddlewareManager<StateType, StateBuilderType, ActionsType> manager = new SagaMiddlewareManager(runnableList);
  manager.run();

  return (MiddlewareApi<StateType, StateBuilderType, ActionsType> api) {
    manager.init(api);

    return manager.next;
  };
}
