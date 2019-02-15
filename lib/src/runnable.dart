import 'package:redux_saga/redux_saga.dart';

abstract class Runnable {
  RunnableStatus run(SagaManager sagaManager);

  static Iterator<Runnable> createTasksFromList(List<Iterable<Runnable>> runnableList) {
    return runnableList.map((runnable) => Task(runnable.iterator)).toList().iterator;
  }
}

enum RunnableStatus {
  Waiting,
  Done
}

typedef void RunnableCallback<ValueType>(ValueType value);