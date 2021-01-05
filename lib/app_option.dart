// Fake locale to represent the system Locale option.
import 'dart:ui';

const systemLocaleOption = Locale('system');

Locale _deviceLocale;
Locale get deviceLocale => _deviceLocale;
set deviceLocale(Locale locale) {
  _deviceLocale ??= locale;
}
