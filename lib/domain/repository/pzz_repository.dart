import 'package:pzz/models/basket.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/models/sauce.dart';

abstract class PzzRepository {
  Future<List<Pizza>> loadPizzas();

  Future<List<Sauce>> loadSauces();

  Future<Basket> loadBasket();

  Future<Basket> addProductToBasket(Product product);

  Future<Basket> removeProductFromBasket(Product product);
}
