import 'dart:async';
import 'process.dart';
import 'package:built_redux/built_redux.dart';
import 'package:redux_saga/redux_saga.dart';
import 'package:built_value/built_value.dart';

class SagaMiddlewareManager<
StateType extends Built<StateType, StateBuilderType>,
StateBuilderType extends Builder<StateType, StateBuilderType>,
ActionsType extends ReduxActions> {
  final ProcessTask _process;

  final StreamController<Object> _observable = new StreamController();

  bool _initialized = false;

  Stream<Object> _actions;

  SagaMiddlewareManager(List<Iterable<Runnable>> runnableList)
      : _process = ProcessTask(Runnable.createTasksFromList(runnableList)) {
    _actions = _observable.stream.asBroadcastStream();
  }

  void init(MiddlewareApi<StateType, StateBuilderType, ActionsType> api) {
    if(!_initialized) {
      _initialized = true;
      this._process.run(this);
    }
  }

  RunnableStatus run() {
    return this._process.run(this);
  }

  ActionHandler next(ActionHandler next) {
    return (Action<dynamic> action) {

      print("sinked:${action}");

      _observable.sink.add(action);

      if (next != null) {
        next(action);
      }
    };
  }

  RunnableStatus get status {
    return this._process.status;
  }

  void put<PayloadType>(ActionName<PayloadType> actionName, PayloadType payload) {
    Action<PayloadType>(actionName.name, payload);
  }

  ValueType select<SelectorType, ValueType>(SelectorType selector) {
    print("selecting:${selector}");
    return selector as ValueType;
  }

  Future<Action<PayloadType>> take<PayloadType>(
      ActionName<PayloadType> actionName) async {
    if (actionName != null) {
      return _actions
          .where((action) => action is Action<PayloadType>)
          .map((action) => action as Action<PayloadType>)
          .where((action) => action.name == actionName.name)
          .first;
    }
    return null;
  }
}
