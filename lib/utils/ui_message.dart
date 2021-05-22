import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../l10n/app_localization_keys.dart';

/// Class for representation of textual content that should be display on screen.
///
/// Case for: user hint/error messages that will be received from BackEnd or assigned into redux state by reducers.
///
/// Motivation - to have control over textual data that should be (or not) localized during showing on screen for user.
/// Also to have ability to store raw (not localized) text into store, this allows avoid storing of irrelevant text
/// if application locale will change.
///
/// Uncovered case: plurals([plural]), complex TKeys with context([TUtils.trWithCtx]). If you need this, you will have
/// to do some extra work and create these implementations following the example of the existing ones.
abstract class UiMessage {
  const UiMessage();

  factory UiMessage.empty() => const UiMessageEmpty();

  factory UiMessage.key(AppLocalizationKeys? kye, [Map<String, String>? params]) => UiMessageKey(kye, params);

  factory UiMessage.text(String? text) => UiMessageText(text ?? '');

  /// Return true if raw textual data is not null and not empty.
  bool get isNotEmpty;

  /// Return true if textual data is null or empty.
  bool get isEmpty;

  /// Return ''(emptyString) if [isEmpty] == true otherwise localized text.
  String localize(AppLocalizations localization);

  /// Return null if [isEmpty] == true otherwise localized text.
  String? tryLocalize(AppLocalizations localization) => isNotEmpty ? localize(localization) : null;
}

class UiMessageText extends UiMessage {
  const UiMessageText(this.text);

  final String text;

  @override
  bool get isEmpty => text.isEmpty;

  @override
  bool get isNotEmpty => !isEmpty;

  @override
  String localize(AppLocalizations localization) => text;

  @override
  String toString() => 'UiMessageText{text: $text}';
}

class UiMessageKey extends UiMessage {
  const UiMessageKey(this.key, [this.params]);

  final AppLocalizationKeys? key;
  final Map<String, String>? params;

  @override
  bool get isEmpty => key == null;

  @override
  bool get isNotEmpty => key != null;

  @override
  String localize(AppLocalizations localization) => key!.localized(localization, params);

  @override
  String toString() => 'UiMessageKey{key: $key, params: $params}';
}

class UiMessageEmpty extends UiMessage {
  const UiMessageEmpty();

  @override
  bool get isEmpty => true;

  @override
  bool get isNotEmpty => false;

  @override
  String localize(AppLocalizations localization) => '';

  @override
  String toString() => 'UiMessageEmpty{}';
}
