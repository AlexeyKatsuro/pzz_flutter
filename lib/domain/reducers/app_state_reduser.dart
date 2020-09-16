import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/reducers/basket_reducer.dart';
import 'package:pzz/domain/reducers/loading_reducer.dart';
import 'package:pzz/domain/reducers/personal_info_reducer.dart';
import 'package:pzz/domain/reducers/pizzas_reducer.dart';
import 'package:pzz/domain/reducers/sauces_reducer.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/street.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    pizzas: pizzasReducer(state.pizzas, action),
    sauce: saucesReducer(state.sauce, action),
    basket: basketReducer(state.basket, action),
    personalInfo: personalInfoReducer(state.personalInfo, action),
    suggestedStreets: suggestedStreetsReducer(state.suggestedStreets, action),
  );
}

final suggestedStreetsReducer = combineReducers<List<Street>>([
  TypedReducer<List<Street>, SearchStreetResultAction>(_setSuggestedStreets),
]);

List<Street> _setSuggestedStreets(List<Street> streets, SearchStreetResultAction action) {
  return action.streets;
}
