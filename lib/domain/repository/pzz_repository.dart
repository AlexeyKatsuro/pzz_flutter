import 'package:pzz/models/basket.dart';
import 'package:pzz/models/person_info/house.dart';
import 'package:pzz/models/person_info/personal_info.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/models/person_info/street.dart';

abstract class PzzRepository {
  Future<List<Pizza>> loadPizzas();

  Future<List<Sauce>> loadSauces();

  Future<Basket> loadBasket();

  Future<Basket> addProductToBasket(Product product);

  Future<Basket> removeProductFromBasket(Product product);

  Future<List<Street>> searchStreet(String query);

  Future<List<House>> loadHousesByStreet(int streetId);

  Future<Basket> updateAddress(PersonalInfo personalInfo);

  Future<Basket> placeOrder();
}
