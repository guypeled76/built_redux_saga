import 'dart:async';

import 'package:redux_saga/redux_saga.dart';
import 'process.dart';
import 'package:built_redux/built_redux.dart';

class SagaManager {

  final ProcessTask _process;

  final StreamController<Object> _observable = new StreamController();

  Stream<Object> _actions;

  SagaManager(List<Iterable<Runnable>> runnableList) :
    _process = ProcessTask(Runnable.createTasksFromList(runnableList)) {

    _actions = _observable.stream.asBroadcastStream();
  }

  Sink<Object> get actions {
    return _observable.sink;
  }

  RunnableStatus run() {
    return this._process.run(this);
  }

  RunnableStatus get status {
    return this._process.status;
  }

  void put<Action>(Action action) {
    print("putting:${action}");
  }

  ValueType select<SelectorType, ValueType>(SelectorType selector) {
    print("selecting:${selector}");
    return selector as ValueType;
  }

  Future<Action<PayloadType>> take<PayloadType>(ActionName<PayloadType> actionName) async {
    if(actionName != null) {
      return _actions
          .where((action) => action is Action<PayloadType>)
          .map((action) => action as Action<PayloadType>)
          .where((action)=> action.name == actionName.name)
          .first;
    }
    return null;
  }



}
