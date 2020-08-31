import 'package:pzz/models/pizza.dart';

class LoadPizzasAction {}

class PizzasLoadedAction {
  final List<Pizza> pizzas;

  PizzasLoadedAction(this.pizzas);
}
