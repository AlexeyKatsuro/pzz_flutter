import 'package:flutter/cupertino.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/utils/scoped.dart';
import 'package:pzz/utils/ui_message.dart';

class InitialAction implements Scoped {
  InitialAction({required this.scope});

  @override
  final String scope;
}

class LoadPizzasAction implements Scoped {
  LoadPizzasAction({required this.scope});

  @override
  final String scope;
}

class LoadBasketAction implements Scoped {
  LoadBasketAction({required this.scope});

  @override
  final String scope;
}

class PizzasLoadedAction {
  PizzasLoadedAction(this.pizzas);

  final List<Pizza> pizzas;
}

class SaucesLoadedAction {
  SaucesLoadedAction(this.sauces);

  final List<Sauce> sauces;
}

class BasketLoadedAction {
  BasketLoadedAction(this.basket);

  final Basket basket;
}

class AddProductAction implements Scoped {
  AddProductAction({required this.product, required this.scope});

  final Product product;

  @override
  final String scope;
}

class RemoveProductAction implements Scoped {
  RemoveProductAction({required this.product, required this.scope});
  final Product product;

  @override
  final String scope;
}

class HomeLoadingAction {
  HomeLoadingAction({required this.isLoading});

  final bool isLoading;
}

class HomeErrorAction {
  HomeErrorAction(this.errorMessage);

  final UiMessage errorMessage;
}

class TryPlaceOrderAction implements Scoped {
  TryPlaceOrderAction({required this.scope});

  @override
  final String scope;
}

class ConfirmPlaceOrderAction implements Scoped {
  ConfirmPlaceOrderAction({required this.scope});

  @override
  final String scope;
}

class ConfirmLoadingAction {
  ConfirmLoadingAction({required this.isLoading});

  final bool isLoading;
}

class OrderPlacedAction {}

class ChangeLocaleAction {
  ChangeLocaleAction(this.locale);

  final Locale locale;
}
