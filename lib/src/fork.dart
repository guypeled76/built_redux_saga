import 'package:redux_saga/redux_saga.dart';

class _ForkEffect extends Task {
  _ForkEffect(Iterable<Runnable> runnable) : super(runnable.iterator, true);
}

Runnable fork(Iterable<Runnable> runnable) {
  return _ForkEffect(runnable);
}