import 'package:redux_saga/redux_saga.dart';

class _Delay<ValueType> extends RunnableFuture {
  final Future<ValueType> _future;


  _Delay(this._future) {
    this._future.then((value) {
      this.done();
    }).catchError((error) {
      this.done();
    });
  }

}



Runnable delay<ValueType>(Duration duration) {
  return _Delay(Future.delayed(duration));
}