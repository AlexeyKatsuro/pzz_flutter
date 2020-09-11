import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/models/sauce.dart';
import 'package:redux/redux.dart';

final saucesReducer = combineReducers<List<Sauce>>([
  TypedReducer<List<Sauce>, SaucesLoadedAction>(setLoadedSauces),
]);

List<Sauce> setLoadedSauces(List<Sauce> sauces, SaucesLoadedAction action) {
  return action.sauces;
}
