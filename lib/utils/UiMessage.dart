import 'package:pzz/l10n/app_localization_keys.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UiMessage {
  final AppLocalizationKeys _key;
  final Map<String, dynamic> _params;
  final String _text;

  const UiMessage.empty()
      : _key = null,
        _text = null,
        _params = null;

  const UiMessage.key(AppLocalizationKeys kye, [Map<String, dynamic> _params])
      : _key = kye,
        _text = null,
        _params = _params;

  const UiMessage.text(String text)
      : _key = null,
        _text = text,
        _params = null;

  bool get isNotEmpty => _key != null || _text != null;

  bool get isEmpty => _key == null && _text == null;

  @override
  String toString() {
    return 'UiMessage{_key: $_key, _params: $_params, _text: $_text}';
  }
}

extension UiMessageExt on UiMessage {
  String localize(AppLocalizations localizations) {
    if (isEmpty) return '';

    return _key.localized(localizations, _params);
  }

  String localizeOrNull(AppLocalizations localizations) {
    if (isEmpty) return null;

    return _key.localized(localizations, _params);
  }
}
