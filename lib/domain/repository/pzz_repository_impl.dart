import 'package:pzz/domain/pzz_net_service.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/pizza.dart';

class PzzRepositoryImpl implements PzzRepository {
  final _service = PzzNetService();

  @override
  Future<Basket> addItem() {
    // TODO: implement addItem
    throw UnimplementedError();
  }

  @override
  Future<Basket> loadBasket() {
    // TODO: implement loadBasket
    throw UnimplementedError();
  }

  @override
  Future<List<Pizza>> loadPizzas() {
    return _service.loadPizzas();
  }

  @override
  Future<Basket> removeItem() {
    // TODO: implement removeItem
    throw UnimplementedError();
  }
}
