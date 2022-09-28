// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/basket_address.dart';
import 'package:pzz/models/basket_product.dart';
import 'package:pzz/models/dto/sause_dto.dart';
import 'package:pzz/models/mappers/pizza_item_response_mapper.dart';
import 'package:pzz/models/mappers/sause_item_response_mapper.dart';
import 'package:pzz/models/person_info/house.dart';
import 'package:pzz/models/person_info/personal_info.dart';
import 'package:pzz/models/person_info/street.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/utils/house_comparator.dart';

class PzzRepositoryMock implements PzzRepository {
  final Future<List<Sauce>> _saucesAsync =
      rootBundle.loadString('assets/sauces.json').then((string) {
    final data = jsonDecode(string)['response']['data'];
    return (data as Iterable)
        .map((e) => SauceDto.fromJson(e as Map<String, dynamic>))
        .map(SauceItemResponseMapper.map)
        .toList(growable: false);
  });
  final Future<List<Pizza>> _pizzasAsync =
      rootBundle.loadString('assets/pizzas.json').then((string) {
    final data = jsonDecode(string)['response']['data'];
    return (data as Iterable).map(PizzaItemResponseMapper.map).toList(growable: false);
  });
  final Future<List<Street>> _streetsAsync =
      rootBundle.loadString('assets/streets.json').then((string) {
    final data = jsonDecode(string)['response']['data'];
    return (data as Iterable).map((item) {
      return Street(
        id: item['id'] as int,
        title: item['title'] as String,
      );
    }).toList(growable: false);
  });
  final Future<List<House>> _housesAsync =
      rootBundle.loadString('assets/houses.json').then((string) {
    final data = jsonDecode(string)['response']['data'];
    return (data as Iterable).map((item) {
      return House(
        id: item['id'] as int,
        title: item['title'] as String,
      );
    }).toList(growable: false)
      ..sort(compareHouse);
  });

  BasketEntity _basket = const BasketEntity.initial();

  @override
  Future<BasketEntity> addProductToBasket(Product product) async {
    return _updateTotal(
      _basket.copyWith(
        items: [
          ..._basket.items,
          BasketProduct(
            id: product.id,
            type: product.type,
            title: product.title,
            size: product.size,
            price: product.price,
          ),
        ],
      ),
    );
  }

  BasketEntity _updateTotal(BasketEntity basket) {
    return _basket = basket.copyWith(
      totalAmount: basket.items.fold<num>(0, (sum, item) => sum + item.price),
    );
  }

  @override
  Future<List<Sauce>> loadSauces() {
    return _saucesAsync;
  }

  @override
  Future<BasketEntity> loadBasket() async {
    return _basket;
  }

  @override
  Future<List<Pizza>> loadPizzas() {
    return _pizzasAsync;
  }

  @override
  Future<BasketEntity> removeProductFromBasket(Product product) async {
    final index = _basket.items.indexWhere(
          (item) =>
      item.id == product.id && item.size == product.size && item.type == product.type,
    );
    return _updateTotal(
      _basket.copyWith(
        items: [..._basket.items]..removeAt(index),
      ),
    );
  }

  @override
  Future<List<Street>> searchStreet(String query) {
    return _streetsAsync.then(
      (streets) => streets.where((street) => street.title.contains(query)).toList(growable: false),
    );
  }

  @override
  Future<List<House>> loadHousesByStreet(int streetId) => _housesAsync;

  @override
  Future<BasketEntity> updateAddress(PersonalInfo personalInfo) async {
    await Future.delayed(const Duration(seconds: 3));
    return _basket = _basket.copyWith(
      address: BasketAddressEntity(
        streetId: personalInfo.streetId,
        houseId: personalInfo.houseId,
        name: personalInfo.name,
        phone: personalInfo.phone,
        street: personalInfo.street,
        house: personalInfo.house,
        flat: personalInfo.flat,
        entrance: personalInfo.entrance,
        floor: personalInfo.floor,
        intercom: personalInfo.intercom,
      ),
    );
  }

  @override
  Future<void> placeOrder() async {
    await Future.delayed(const Duration(seconds: 3));
    _basket = const BasketEntity.initial();
  }
}
