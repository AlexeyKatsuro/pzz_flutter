import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/models/basket.dart';
import 'package:redux/redux.dart';

final basketReducer = combineReducers<Basket>([
  TypedReducer<Basket, BasketLoadedAction>(_setLoadedBasket),
]);

Basket _setLoadedBasket(Basket basket, BasketLoadedAction action) {
  return action.basket;
}
