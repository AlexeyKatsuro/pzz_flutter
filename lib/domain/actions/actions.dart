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

class AddPizzaAction {
  final Pizza pizza;
  final PizzaSize size;

  AddPizzaAction(this.pizza, this.size);
}
