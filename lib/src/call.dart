import 'package:built_redux_saga/built_redux_saga.dart';

class _Call<ValueType> extends RunnableFuture {
  final Future<ValueType> _future;

  _Call(this._future, [RunnableCallback<ValueType> _success, RunnableErrorHandler _error]) : super(_success, _error) {

  }

  void _bind() async {
      try {
        ValueType value = await this._future;
        this.successHandler(value);
      } catch(e) {
        this.errorHandler(e);
      }
  }

  @override
  get errorMessage => "Failed to execute call transaction.";
}



Runnable call<ValueType>(Future<ValueType> future, [Result<ValueType> result]) {
  _Call runnable = _Call(future, result?.onSuccess, result?.onError);
  runnable._bind();
  return runnable;
}