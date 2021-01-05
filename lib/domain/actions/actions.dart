import 'package:flutter/cupertino.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/utils/UiMessage.dart';
import 'package:pzz/utils/scoped.dart';

class InitialAction implements Scoped {
  final String scope;

  @override
  InitialAction({@required this.scope});
}

class LoadPizzasAction {}

class LoadBasketAction implements Scoped {
  LoadBasketAction({@required this.scope});

  @override
  final String scope;
}

class PizzasLoadedAction {
  final List<Pizza> pizzas;

  PizzasLoadedAction(this.pizzas) : assert(pizzas != null);
}

class SaucesLoadedAction {
  final List<Sauce> sauces;

  SaucesLoadedAction(this.sauces) : assert(sauces != null);
}

class BasketLoadedAction {
  final Basket basket;

  BasketLoadedAction(this.basket) : assert(basket != null);
}

class AddProductAction implements Scoped {
  final Product product;
  final String scope;

  AddProductAction({@required this.product, @required this.scope}) : assert(product != null);
}

class RemoveProductAction implements Scoped {
  final Product product;
  final String scope;

  RemoveProductAction({@required this.product, @required this.scope});
}

class HomeLoadingAction {
  HomeLoadingAction(this.isLoading);

  final bool isLoading;
}

class HomeErrorAction {
  final UiMessage errorMessage;

  HomeErrorAction(this.errorMessage);
}

class TryPlaceOrderAction implements Scoped {
  TryPlaceOrderAction({@required this.scope});

  @override
  final String scope;
}

class ConfirmPlaceOrderAction implements Scoped {
  ConfirmPlaceOrderAction({@required this.scope});

  @override
  final String scope;
}

class ConfirmLoadingAction {
  ConfirmLoadingAction({this.isLoading});

  final bool isLoading;
}

class OrderPlacedAction {}

class ChangeLocaleAction {
  final Locale locale;

  ChangeLocaleAction(this.locale);
}
