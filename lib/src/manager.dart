import 'package:redux_saga/redux_saga.dart';
import 'process.dart';

class SagaManager {

  final ProcessTask _process;

  SagaManager(List<Iterable<Runnable>> runnableList) :
    _process = ProcessTask(Runnable.createTasksFromList(runnableList)) {
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

  Future<ValueType> take<SelectorType, ValueType>(SelectorType selector) async {
    print("take:${selector}");
    return selector as ValueType;
  }



}
