import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:pzz/domain/error/standard_pzz_error.dart';
import 'package:pzz/res/strings.dart';

/// Parse [error] to meaningful and useful messages for the user.
String errorMessageExtractor(Object error) {
  if (error is PzzServerError) {
    return error.message;
  } else if (error is SocketException) {
    return StringRes.error_connection;
  }
  // Add new check for other `Exception` that can be happens in domain layer
  // and which can be mapped to user friendly string messages

  if (kDebugMode) {
    // for debug return full data about unchecked error
    return error.toString();
  }
  return 'Unexpected error';
}
