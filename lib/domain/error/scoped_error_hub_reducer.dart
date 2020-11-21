import 'package:pzz/domain/error/scoped_error_actions.dart';
import 'package:pzz/domain/error/scoped_error_hub.dart';
import 'package:redux/redux.dart';

Reducer<ScopedErrorsHub> scopedErrorHubReducer = combineReducers([
  TypedReducer<ScopedErrorsHub, SetScopedErrorAction>(setScopedErrorReducer),
]);

ScopedErrorsHub setScopedErrorReducer(ScopedErrorsHub hub, SetScopedErrorAction action) {
  return hub.set(scope: action.scope, error: action.error);
}
