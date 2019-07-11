import 'dart:async';
import 'process.dart';
import 'package:built_redux/built_redux.dart';
import 'package:built_redux_saga/built_redux_saga.dart';
import 'package:built_value/built_value.dart';



class SagaMiddlewareManager<
StateType extends Built<StateType, StateBuilderType>,
StateBuilderType extends Builder<StateType, StateBuilderType>,
ActionsType extends ReduxActions> {
  final ProcessTask _process;

  final StreamController<Object> _observable = new StreamController(sync: true);

  bool _initialized = false;

  Stream<Object> _actions;

  ActionHandler _handler;

  Map<Type, Function> _registry = new Map();

  SagaMiddlewareManager(List<Iterable<Runnable>> runnableList)
      : _process = ProcessTask(Runnable.createTasksFromList(runnableList)) {
    _actions = _observable.stream.asBroadcastStream();
  }

  void init(MiddlewareApi<StateType, StateBuilderType, ActionsType> api) {
    if(!_initialized) {
      _initialized = true;
      this.register<ActionsType>(() => api?.actions);
      this.register<StateType>(() => api?.state);
      this._process.run(this);
    }
  }

  RunnableStatus run() {
    return this._process.run(this);
  }

  ActionHandler next(ActionHandler next) {
    return _handler = (Action<dynamic> action) {

      if (next != null) {
        next(action);
      }

      _observable.sink.add(action);


    };
  }

  RunnableStatus get status {
    return this._process.status;
  }

  void put<PayloadType>(ActionName<PayloadType> actionName, PayloadType payload) {
    _handler(Action<PayloadType>(actionName.name, payload));
  }

  void register<Type>(Function factory) {
    _registry[Type] = factory;
  }

  ResultType select<ResultType>() {
    Function factory = this._registry[ResultType];
    if(factory != null){
      Object result = factory();
      if(result is ResultType){
        return result;
      }
    }

    return null;
  }

  Future<Action<Object>> takeEverything() async {
    return _actions
        .where((action) => action is Action<Object>)
        .map((action) => action as Action<Object>).first;
  }

  Future<Action<PayloadType>> take<PayloadType>(
      ActionName<PayloadType> actionName) async {
    if (actionName != null) {
      return _actions
          .where((action)  {
            return action is Action<PayloadType>;
          })
          .map((action) {
            return action as Action<PayloadType>;
          })
          .where((action) => action.name == actionName.name)
          .first;
    }
    return null;
  }

  void fatalError(e) {

  }
}
