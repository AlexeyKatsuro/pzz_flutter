import 'package:pzz/models/basket.dart';
import 'package:pzz/models/house.dart';
import 'package:pzz/models/personal_info.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/models/street.dart';

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

class PerformStreetSearchAction {
  final String query;

  PerformStreetSearchAction(this.query);
}

class PerformHouseSearchAction {
  final String query;

  PerformHouseSearchAction(this.query);
}

class SearchStreetErrorAction {
  final dynamic error;

  SearchStreetErrorAction(this.error);
}

class SearchStreetResultAction {
  final List<Street> streets;

  SearchStreetResultAction(this.streets);
}

class CancelStreetSearchAction {}

class SelectStreetAction {
  final Street street;

  SelectStreetAction(this.street);
}

class LoadedHouseAction {
  final List<House> houses;

  LoadedHouseAction(this.houses);
}

class SelectHouseAction {
  final House house;

  SelectHouseAction(this.house);
}
