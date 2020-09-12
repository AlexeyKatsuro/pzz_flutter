import 'package:pzz/models/personal_info.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';

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

class SavePersonalInfoAction {
  final PersonalInfo info;

  SavePersonalInfoAction(this.info);
}
