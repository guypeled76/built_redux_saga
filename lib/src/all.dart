import 'package:built_redux_saga/built_redux_saga.dart';

class _AllEffect extends Task {
  _AllEffect(Iterator<Runnable> runnables) : super(runnables, true);
  
}

Runnable all(List<Iterable<Runnable>> runnablesList) {
  return _AllEffect(Runnable.createTasksFromList(runnablesList));
}