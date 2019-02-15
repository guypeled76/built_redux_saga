import 'package:redux_saga/redux_saga.dart';

class _Delay<ValueType> extends Runnable {
  final Future<ValueType> _future;

  RunnableStatus _status = RunnableStatus.Waiting;

  _Delay(this._future) {
    this._future.then((value) {
      this._status = RunnableStatus.Done;
    }).catchError((error) {
      this._status = RunnableStatus.Done;
    });
  }

  @override
  RunnableStatus run(SagaManager sagaManager) {
    return this._status;
  }

}



Runnable delay<ValueType>(Duration duration) {
  return _Delay(Future.delayed(duration));
}