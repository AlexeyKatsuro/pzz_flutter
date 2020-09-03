import 'package:pzz/models/basket.dart';
import 'package:pzz/models/pizza.dart';

abstract class PzzRepository {
  Future<List<Pizza>> loadPizzas();
  Future<Basket> loadBasket();
  Future<Basket> addPizzaItem(Pizza pizza, PizzaSize size);
  Future<Basket> removePizzaItem(Pizza pizza, PizzaSize size);
}
