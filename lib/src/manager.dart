import 'package:redux_saga/redux_saga.dart';
import 'dart:collection';

class SagaManager {

  final Task _main;

  final Queue<_process> _processes = new Queue();

  bool _running = false;

  RunnableStatus _status = RunnableStatus.Done;

  SagaManager(List<Iterable<Runnable>> runnableList) :
    _main = Task(Runnable.createTasksFromList(runnableList), false) {
  }


  RunnableStatus run() {
    _processes.add(() => _main.run(this));

    if(!_running) {
      try {
        _running = true;

        while (_processes.isNotEmpty) {
          _status = RunnableStatus.Waiting;
          _status = _processes.removeFirst()();
        }
      } finally {
        _running = false;
      }
    }
    return _status;
  }

  RunnableStatus get status {
    return this._status;
  }

  void put<Action>(Action action) {
    print("putting:${action}");
  }

  ValueType select<SelectorType, ValueType>(SelectorType selector) {
    print("selecting:${selector}");
    return selector as ValueType;
  }

  ValueType take<SelectorType, ValueType>(SelectorType selector) {
    print("take:${selector}");
    return selector as ValueType;
  }



}

typedef RunnableStatus _process();