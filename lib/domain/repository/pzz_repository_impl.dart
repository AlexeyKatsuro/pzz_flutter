import 'package:pzz/domain/pzz_net_service.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/pizza.dart';

class PzzRepositoryImpl implements PzzRepository {
  final _service = PzzNetService();

  @override
  Future<Basket> addPizzaItem(Pizza pizza, PizzaSize size) {
    return _service.addPizzaItem(pizza, size);
  }

  @override
  Future<Basket> loadBasket() {
    return _service.loadBasket();
  }

  @override
  Future<List<Pizza>> loadPizzas() {
    return _service.loadPizzas();
  }

  @override
  Future<Basket> removePizzaItem(Pizza pizza, PizzaSize size) {
    return _service.removePizzaItem(pizza, size);
  }
}
