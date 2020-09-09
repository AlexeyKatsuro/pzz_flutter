import 'package:flutter/cupertino.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/pizza.dart';

class InitialAction {}

class LoadPizzasAction {}

class LoadBasketAction {}

class PizzasLoadedAction {
  final List<Pizza> pizzas;

  PizzasLoadedAction(this.pizzas);
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

class Product {
  final int id;
  final ProductSize size;
  final ProductType type;

  Product({@required this.id, @required this.type, this.size})
      : assert(id != null),
        assert(type != null);
}
