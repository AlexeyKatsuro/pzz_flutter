import 'dart:core';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:pzz/app_option.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/basket_product.dart';
import 'package:pzz/models/combined_basket_product.dart';
import 'package:pzz/models/home_page_state.dart';
import 'package:pzz/models/navigation_stack.dart';
import 'package:pzz/models/payment_way.dart';
import 'package:pzz/models/person_info/house.dart';
import 'package:pzz/models/person_info/person_info_errors.dart';
import 'package:pzz/models/person_info/personal_info.dart';
import 'package:pzz/models/person_info/street.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/utils/UiMessage.dart';
import 'package:reselect/reselect.dart';

NavigationStack navigationStackSelector(AppState state) => state.navigationStack;

Basket basketSelector(AppState state) => state.basket;

HomePageState homePageStateSelector(AppState state) => state.homePageState;

List<BasketProduct> basketProductsSelector(AppState state) => basketSelector(state).items;

int basketCountSelector(AppState state) => basketProductsSelector(state).length;

List<Pizza> pizzasSelector(AppState state) => state.pizzas;

List<Sauce> saucesSelector(AppState state) => state.sauce;

PersonalInfo personalInfoSelector(AppState state) => state.personalInfoState.formInfo;

PersonalInfoErrors personalInfoErrorsSelector(AppState state) => state.personalInfoState.formInfoErrors;

bool isHomeSelectionAllowSelector(AppState state) => state.personalInfoState.formInfo.streetId != 0;

List<Street> suggestedStreetsSelector(AppState state) => state.personalInfoState.suggestedStreets;

List<House> suggestedHousesSelector(AppState state) => state.personalInfoState.suggestedHouses;

List<House> totalHousesSelector(AppState state) => state.personalInfoState.totalHouses;

Selector<AppState, Street> personalInfoStreetSelector = createSelector1(personalInfoSelector, (PersonalInfo info) {
  return Street(id: info.streetId, title: info.street);
});

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

/// Curried function from 2 arguments
Selector<AppState, List<CombinedBasketProduct>> combinedBasketProductsByTypeSelector2(ProductType type) =>
    createSelector1(
      combinedBasketProductsTypedMap,
      (Map<ProductType, List<CombinedBasketProduct>> productMap) {
        return productMap[type] ?? [];
      },
    );

/// Return list of combined sauces in basket
Selector<AppState, List<CombinedBasketProduct>> combinedBasketSaucesSelector =
    combinedBasketProductsByTypeSelector2(ProductType.sauce);

Selector<AppState, List<CombinedBasketProduct>> combinedBasketProducts =
    createSelector1(combinedBasketProductsTypedMap, (Map<ProductType, List<CombinedBasketProduct>> combinedProductMap) {
  return combinedProductMap.values.fold([], (value, element) => value + element);
});

CombinedBasketProduct combinedProductSelectorBy(AppState state, ProductType type, int productId) {
  final map = combinedBasketProductsTypedMap(state);
  final typedProducts = map[type];
  return typedProducts?.firstWhere((element) => element.id == productId, orElse: () => null);
}

/// Return count of free sauces
Selector<AppState, int> freeSauceCountsSelector = createSelector1(
  combinedBasketProductsTypedMap,
  (Map<ProductType, List<CombinedBasketProduct>> productMap) {
    final count =
        (productMap[ProductType.pizza]?.allProductsCount ?? 0) - (productMap[ProductType.sauce]?.allProductsCount ?? 0);
    return count > 0 ? count : 0;
  },
);

Selector<AppState, Map<int, int>> saucesCountsMapSelector = createSelector2(
  saucesSelector,
  combinedBasketSaucesSelector,
  (List<Sauce> sauces, List<CombinedBasketProduct> combinedSauces) {
    final Map<int, int> saucesCountsMap = {};
    for (final sauce in sauces) {
      saucesCountsMap[sauce.id] =
          combinedSauces.firstWhere((element) => element.id == sauce.id, orElse: () => null)?.productsCount ?? 0;
    }
    return saucesCountsMap;
  },
);

PaymentWay paymentWaySelector(AppState state) => state.personalInfoState.formInfo.paymentWay;

PersonalInfoErrors personInfoFormErrorsSelector(AppState state) => state.personalInfoState.formInfoErrors;

UiMessage paymentWayErrorSelector(AppState state) => personInfoFormErrorsSelector(state).paymentWay;

Selector<AppState, bool> isPersonInfoValid = createSelector1(
  personInfoFormErrorsSelector,
  (PersonalInfoErrors errors) {
    return !errors.hasErrors;
  },
);

String rentingSelector(AppState state) => state.personalInfoState.formInfo.renting;

bool isConfirmLoadingSelector(AppState state) => state.isConfirmLoading;

Locale appLocaleSelector(AppState state) => state.locale ?? deviceLocale;
