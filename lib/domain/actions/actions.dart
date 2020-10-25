import 'package:pzz/models/basket.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/models/sauce.dart';

class InitialAction {}

class LoadPizzasAction {}

class LoadBasketAction {}

class PizzasLoadedAction {
  final List<Pizza> pizzas;

  PizzasLoadedAction(this.pizzas);
}

class SaucesLoadedAction {
  final List<Sauce> sauces;

  SaucesLoadedAction(this.sauces);
}

class BasketLoadedAction {
  final Basket basket;

  BasketLoadedAction(this.basket);
}

class AddProductAction {
  final Product product;

  AddProductAction(this.product);
}

class RemoveProductAction {
  final Product product;

  RemoveProductAction(this.product);
}

class StartLoadingAction {}

class StopLoadingAction {}

class TryPlaceOrderAction {}

class ConfirmPlaceOrderAction {}

class ConfirmLoadingAction {
  ConfirmLoadingAction({this.isLoading});

  final bool isLoading;
}

class ShowConfirmOrderDialogAction {}

class HandleConfirmOrderDialogAction {}
