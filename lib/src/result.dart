
import 'index.dart';

class Result<ValueType> {
  
  
  ValueType _value;
  
  Error _error;
  
  get error => _error;
  get value => _value;
  get hasError => _error != null;
  

  void onError(Error error) {
    _error = error;
  }

  void onSuccess(ValueType value) {
    _value = value;
  }
}

class ResultHandler<ValueType> extends Result<ValueType> {

  final RunnableCallback<ValueType> successHandler;
  
  final RunnableCallback<Error> errorHandler;
  
  ResultHandler(this.successHandler,[this.errorHandler]);
  
  @override
  void onError(Error error) {
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
