// nullable
import 'package:pzz/models/app_state.dart';
import 'package:pzz/utils/ui_message.dart';

UiMessage? getScopedErrorSelector(AppState state, String scope) => state.scopedErrors.get(scope);
