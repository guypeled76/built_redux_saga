import 'package:built_redux_saga/built_redux_saga.dart';



Runnable fork(Iterable<Runnable> runnable, [Result<Task> result]) {
  Task task = ForkTask(runnable);
  if(result != null) {
    result.onSuccess(task);
  }
  return task;
}