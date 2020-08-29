abstract class Result<T> {

  T get data;

  static Result<R> runCatch<R>(R Function() function) {
    try {
      return Success<R>(function());
    } catch (ex) {

      return Failure<R>(ex);
    }
  }
}

class Failure<T> extends Result<T> {
  final Exception error;

  Failure(this.error);

  @override
  T get data => null;

}
class Success<T> extends Result<T> {

  final T _data;
  Success(this._data);

  @override
  T get data => _data;



}