import 'package:pzz/models/basket.dart';
import 'package:pzz/models/person_info/house.dart';
import 'package:pzz/models/person_info/personal_info.dart';
import 'package:pzz/models/person_info/street.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/models/sauce.dart';

abstract class PzzRepository {
  Future<List<Pizza>> loadPizzas();

  Future<List<Sauce>> loadSauces();

  Future<BasketEntity> loadBasket();

  Future<BasketEntity> addProductToBasket(Product product);

  Future<BasketEntity> removeProductFromBasket(Product product);

  Future<List<Street>> searchStreet(String query);

  Future<List<House>> loadHousesByStreet(int streetId);

  Future<BasketEntity> updateAddress(PersonalInfo personalInfo);

  Future<void> placeOrder();
}
