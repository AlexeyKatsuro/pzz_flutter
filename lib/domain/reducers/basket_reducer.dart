import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/models/basket.dart';
import 'package:redux/redux.dart';

final basketReducer = combineReducers<BasketEntity>([
  TypedReducer<BasketEntity, BasketLoadedAction>(_setLoadedBasket),
]);

BasketEntity _setLoadedBasket(BasketEntity basket, BasketLoadedAction action) {
  return action.basket;
}
