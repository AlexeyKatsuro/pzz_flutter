import 'package:pzz/domain/actions/actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, LoadPizzasAction>(_startLoading),
  TypedReducer<bool, PizzasLoadedAction>(_stopLoading),
]);

bool _startLoading(bool state, LoadPizzasAction action) {
  return true;
}

bool _stopLoading(bool state, PizzasLoadedAction action) {
  return false;
}
