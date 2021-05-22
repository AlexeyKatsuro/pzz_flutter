abstract class Result<T> {
  T get data;

  static Result<R?> runCatch<R>(R Function() function) {
    try {
      return Success<R>(function());
    } catch (ex) {
      return Failure<R>(ex);
    }
  }
}

class Failure<T> extends Result<T?> {
  Failure(this.error);

  final Object error;

  @override
  T? get data => null;
}

class Success<T> extends Result<T> {
  Success(this._data);

  final T _data;

  @override
  T get data => _data;
}
