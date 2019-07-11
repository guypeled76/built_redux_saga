
import 'index.dart';

class Result<ValueType> {
  
  
  ValueType _value;

  RunnableError _error;
  
  get error => _error;
  get value => _value;
  get hasError => _error != null;
  get hasValue => _value != null;

  void throwErrorIfExists() {
    if(this.hasError) {
      throw this.error;
    }
  }

  void onError(RunnableError error) {
    _error = error;
  }

  void onSuccess(ValueType value) {
    _value = value;
  }
}

class ResultHandler<ValueType> extends Result<ValueType> {

  final RunnableCallback<ValueType> successHandler;
  
  final RunnableErrorHandler errorHandler;
  
  ResultHandler(this.successHandler,[this.errorHandler]);
  
  @override
  void onError(RunnableError error) {
    super.onError(error);
    if(this.errorHandler != null) {
      this.errorHandler(error);
    }
  }
  
  @override
  void onSuccess(ValueType value) {
    super.onSuccess(value);
    if(this.successHandler!= null) {
      this.successHandler(value);
    }
  }
}
