import 'package:redux_saga/redux_saga.dart';

Runnable delay<ValueType>(Duration duration) {
  return call(Future.delayed(duration));
}