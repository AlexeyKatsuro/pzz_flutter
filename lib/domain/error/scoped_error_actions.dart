import 'package:pzz/utils/ui_message.dart';
import 'package:pzz/utils/scoped.dart';

/// General action to set error message for specific [scope].
class SetScopedErrorAction implements Scoped {
  SetScopedErrorAction({required this.error, required this.scope});

  final UiMessage? error;
  @override
  final String scope;
}

/// General action to clear error message for specific [scope].
class ClearScopedErrorAction extends SetScopedErrorAction {
  ClearScopedErrorAction({required String scope}) : super(scope: scope, error: null);
}
