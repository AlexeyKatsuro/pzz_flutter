import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/pizza.dart';

abstract class PzzRepository {
  Future<List<Pizza>> loadPizzas();
  Future<Basket> loadBasket();
  Future<Basket> addProductToBasket(Product product);
  Future<Basket> removeProductFromBasket(Product product);
}
