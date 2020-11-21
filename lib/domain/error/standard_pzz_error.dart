import 'package:pzz/res/strings.dart';

class PzzServerError implements Exception {
  final String message;

  PzzServerError(this.message);

  factory PzzServerError.fromJson(Map<String, dynamic> body) {
    final payload = (body['data'] ?? body['response']);

    return PzzServerError(payload != null ? payload['message'] : StringRes.error_unexpected);
  }

  @override
  String toString() {
    return 'PzzServerError{message: $message}';
  }
}
