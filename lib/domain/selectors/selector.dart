import 'dart:core';

import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/basket_product.dart';
import 'package:pzz/models/pizza.dart';

Basket basketSelector(AppState state) => state.basket;

List<BasketProduct> basketProductsSelector(AppState state) => basketSelector(state).items;

int basketCountSelector(AppState state) => basketProductsSelector(state).length;

List<Pizza> pizzasSelector(AppState state) => state.pizzas;

/*
Map<ProductSize, int> basketCountMap(Store<AppState> store, Pizza pizza) {
  final Iterable<BasketProduct> pizzasItems = store.state.basket.items.where((element) => element.id == pizza.id);
  log('------------$pizzasItems');
  Map<ProductSize, List<BasketProduct>> sizeItemsMap = groupBy(pizzasItems, (BasketProduct e) => e.size);

  return sizeItemsMap.map((key, value) => MapEntry(key, value.length));
}
*/
