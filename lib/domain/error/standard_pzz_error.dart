import 'package:pzz/l10n/app_localization_keys.dart';
import 'package:pzz/utils/ui_message.dart';

class PzzServerError implements Exception {
  PzzServerError(this.message);

  factory PzzServerError.fromJson(Map<String, dynamic> body) {
    final payload = (body['data'] ?? body['response']) as Map<String, dynamic>?;
    final message = payload != null
        ? UiMessage.text(payload['message'] as String)
        : UiMessage.key(AppLocalizationKeys.errorUnexpected);
    return PzzServerError(message);
  }

  final UiMessage message;

  @override
  String toString() {
    return 'PzzServerError{message: $message}';
  }
}
