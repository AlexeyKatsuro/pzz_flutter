import 'package:flutter/cupertino.dart';
import 'package:pzz/utils/ui_message.dart';

/// Class to contain all error messages over the App, which should be displayed on different Screen.
///
/// Error messages stores in map by specific `scope` as key.
///
/// See also:
/// * [SetScopedErrorAction]
/// * [ClearScopedErrorAction]
/// * [scopedErrorHubReducer]
/// * [getScopedErrorSelector]
/// * [ErrorScopedNotifier]
@immutable
class ScopedErrorsHub {
  const ScopedErrorsHub._(this._scopedErrors);

  const ScopedErrorsHub.initial() : _scopedErrors = const {};

  final Map<String, UiMessage?> _scopedErrors;

  UiMessage? get(String scope) => _scopedErrors[scope];

  ScopedErrorsHub set({required String scope, required UiMessage? error}) =>
      _copy().._scopedErrors[scope] = error;

  ScopedErrorsHub clear(String scope) => set(scope: scope, error: null);

  ScopedErrorsHub _copy() => ScopedErrorsHub._(Map.from(_scopedErrors));
}
