import 'package:built_redux_saga/built_redux_saga.dart';

class _Execute<ValueType> extends RunnableFuture {
  final Future _future;

  _Execute(this._future, [RunnableCallback _success, RunnableErrorHandler _error]) : super(_success, _error) {

  }

  void _bind() async {
      try {
        await this._future;
        this.successHandler(null);
      } catch(e) {
        this.errorHandler(e);
      }
  }

  @override
  get errorMessage => "Failed to execute execute transaction.";
}



Runnable execute<ValueType>(Future future, [Result<ValueType> result]) {
  _Execute runnable = _Execute(future, result?.onSuccess, result?.onError);
  runnable._bind();
  return runnable;
}