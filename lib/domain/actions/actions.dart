import 'package:flutter/cupertino.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/utils/scoped.dart';

class InitialAction implements Scoped {
  final String scope;

  InitialAction({@required this.scope});
}

class LoadPizzasAction {}

class LoadBasketAction {}

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
  final String errorMessage;

  HomeErrorAction(this.errorMessage);
}

class TryPlaceOrderAction {}

class ConfirmPlaceOrderAction {}

class ConfirmLoadingAction {
  ConfirmLoadingAction({this.isLoading});

  final bool isLoading;
}

class ShowConfirmOrderDialogAction {}

class HandleConfirmOrderDialogAction {}
