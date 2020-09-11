import 'package:pzz/domain/actions/actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, StartLoadingAction>(_startLoading),
  TypedReducer<bool, StopLoadingAction>(_stopLoading),
]);

bool _startLoading(bool state, StartLoadingAction action) {
  return true;
}

bool _stopLoading(bool state, StopLoadingAction action) {
  return false;
}
