import 'package:redux_saga/redux_saga.dart';

class _AllEffect extends Task {
  _AllEffect(Iterator<Runnable> runnables) : super(runnables, false);
  
}

Runnable all(List<Iterable<Runnable>> runnablesList) {
  return _AllEffect(Runnable.createTasksFromList(runnablesList));
}