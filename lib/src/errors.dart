
class RunnableError extends Error {

  final String message;

  final Object error;

  final StackTrace stackTrace;

  RunnableError(this.message, [this.error, this.stackTrace]);
  
  @override
  String toString() {
    return "{$message}\nerror:\n{$error}\nstack:\n{$stackTrace}";
  }
}