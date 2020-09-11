import 'dart:core';

import 'package:collection/collection.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/basket_product.dart';
import 'package:pzz/models/combined_basket_product.dart';
import 'package:pzz/models/pizza.dart';
import 'package:reselect/reselect.dart';

Basket basketSelector(AppState state) => state.basket;

List<BasketProduct> basketProductsSelector(AppState state) => basketSelector(state).items;

int basketCountSelector(AppState state) => basketProductsSelector(state).length;

List<Pizza> pizzasSelector(AppState state) => state.pizzas;

Selector<AppState, Map<ProductType, List<CombinedBasketProduct>>> combinedBasketProductsTypedMap =
    createSelector1(basketProductsSelector, (List<BasketProduct> products) {
  Map<ProductType, List<BasketProduct>> typeMap = groupBy(products, (BasketProduct e) => e.type);

  return typeMap.map((key, products) {
    Map<int, List<BasketProduct>> equalProductsMap = groupBy(products, (BasketProduct e) => e.id);
    List<CombinedBasketProduct> combinedList = equalProductsMap.entries.map((e) {
      final item = e.value.first;
      return CombinedBasketProduct(
        id: item.id,
        type: item.type,
        title: item.title,
        products: e.value,
      );
    }).toList(growable: false);
    return MapEntry(key, combinedList);
  });
});

Selector<AppState, List<CombinedBasketProduct>> combinedBasketProducts =
    createSelector1(combinedBasketProductsTypedMap, (Map<ProductType, List<CombinedBasketProduct>> combinedProductMap) {
  return combinedProductMap.values.fold([], (value, element) => value + element);
});

CombinedBasketProduct combinedProductSelectorBy(AppState state, ProductType type, int productId) {
  final map = combinedBasketProductsTypedMap(state);
  final typedProducts = map[type];
  return typedProducts?.firstWhere((element) => element.id == productId, orElse: () => null);
}