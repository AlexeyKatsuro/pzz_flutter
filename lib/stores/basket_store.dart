import 'dart:async';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/basket_product.dart';
import 'package:pzz/models/combined_basket_product.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/utils/extensions/to_product_ext.dart';

part 'basket_store.g.dart';

class BasketStore = BasketStoreBase with _$BasketStore;

abstract class BasketStoreBase with Store {
  BasketStoreBase({required PzzRepository pzzRepository}) : _pzzRepository = pzzRepository {
    _fetchBasket();
  }

  final PzzRepository _pzzRepository;

  @observable
  BasketEntity basket = const BasketEntity.initial();

  @computed
  Map<ProductType, List<BasketProduct>> get productsByType =>
      groupBy(basket.items, (BasketProduct e) => e.type);

  @computed
  Map<ProductType, List<CombinedBasketProduct>> get combinedProductBy {
    return productsByType.map((key, products) {
      final Map<int, List<BasketProduct>> equalProductsMap =
          groupBy(products, (BasketProduct e) => e.id);
      final List<CombinedBasketProduct> combinedList = equalProductsMap.entries.map((e) {
        final item = e.value.first;
        return CombinedBasketProduct(
          id: item.id,
          type: item.type,
          title: item.title,
          products: e.value,
        );
      }).toList(growable: false);
      return MapEntry(key, combinedList);
    });
  }

  @action
  Future<void> onAddPizzaClick(Pizza pizza, ProductSize size) async {
    try {
      basket = await _pzzRepository.addProductToBasket(pizza.toProduct(size));
    } catch (error) {
      /*Handle error*/
    }
  }

  @action
  Future<void> onRemovePizzaClick(Pizza pizza, ProductSize size) async {
    try {
      basket = await _pzzRepository.removeProductFromBasket(pizza.toProduct(size));
    } catch (error) {
      /*Handle error*/
    }
  }

  @action
  Future<void> _fetchBasket() async {
    try {
      basket = await _pzzRepository.loadBasket();
    } catch (error) {
      /*Handle error*/
    }
  }
}
