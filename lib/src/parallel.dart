import 'package:redux_saga/redux_saga.dart';

abstract class Parallel extends Task {

  Parallel(Iterator<Runnable> runnables) : super(runnables);

  @override
  bool get parallel => true;

}