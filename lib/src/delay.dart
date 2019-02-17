import 'package:built_redux_saga/built_redux_saga.dart';

Runnable delay<ValueType>(Duration duration) {
  return call(Future.delayed(duration));
}