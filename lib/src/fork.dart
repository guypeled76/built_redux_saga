import 'package:redux_saga/redux_saga.dart';

class _ForkEffect extends Parallel {
  _ForkEffect(List<Iterable<Runnable>> runnableList) : super(Runnable.createTasksFromList(runnableList));
}

Runnable fork(List<Iterable<Runnable>> runnableList) {
  return _ForkEffect(runnableList);
}