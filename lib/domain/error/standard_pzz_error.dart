import 'package:pzz/l10n/app_localization_keys.dart';
import 'package:pzz/utils/UiMessage.dart';

class PzzServerError implements Exception {
  final UiMessage message;

  PzzServerError(this.message);

  factory PzzServerError.fromJson(Map<String, dynamic> body) {
    final payload = (body['data'] ?? body['response']);
    final message =
        payload != null ? UiMessage.text(payload['message']) : UiMessage.key(AppLocalizationKeys.errorUnexpected);
    return PzzServerError(message);
  }

  @override
  String toString() {
    return 'PzzServerError{message: $message}';
  }
}
