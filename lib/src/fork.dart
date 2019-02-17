import 'package:built_redux_saga/built_redux_saga.dart';



Runnable fork(Iterable<Runnable> runnable, [RunnableCallback<Task> result]) {
  Task task = ForkTask(runnable);
  if(result != null) {
    result(task);
  }
  return task;
}