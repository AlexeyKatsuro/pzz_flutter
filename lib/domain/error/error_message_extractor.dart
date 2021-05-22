import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:pzz/domain/error/standard_pzz_error.dart';
import 'package:pzz/l10n/app_localization_keys.dart';
import 'package:pzz/utils/ui_message.dart';

/// Parse [error] to meaningful and useful messages for the user.
UiMessage errorMessageExtractor(dynamic error) {
  if (error is PzzServerError) {
    return error.message;
  } else if (error is SocketException) {
    return const UiMessage.key(AppLocalizationKeys.errorConnection);
  }
  // Add new check for other `Exception` that can be happens in domain layer
  // and which can be mapped to user friendly string messages

  if (kDebugMode) {
    // for debug return full data about unchecked error
    return UiMessage.text(error.toString());
  }
  return const UiMessage.text('Unexpected error');
}
