import 'package:redux_saga/redux_saga.dart';

class _ForkEffect extends Task {
  _ForkEffect(List<Iterable<Runnable>> runnableList) : super(Runnable.createTasksFromList(runnableList), true);
}

Runnable fork(List<Iterable<Runnable>> runnableList) {
  return _ForkEffect(runnableList);
}