import 'package:redux_saga/redux_saga.dart';

class SagaManager {

  final Task _main;

  SagaManager(Iterable<Runnable> runnables) :
    _main = Task(runnables.iterator, false);


  RunnableStatus run() {
    return _main.run(this);
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