import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/models/pizza.dart';
import 'package:redux/redux.dart';

final pizzasReducer = combineReducers<List<Pizza>>([
  TypedReducer<List<Pizza>, PizzasLoadedAction>(_setLoadedPizzas),
]);

List<Pizza> _setLoadedPizzas(List<Pizza> pizzas, PizzasLoadedAction action) {
  return action.pizzas;
}
