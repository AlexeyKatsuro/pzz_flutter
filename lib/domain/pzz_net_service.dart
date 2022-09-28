// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pzz/domain/error/error_message_extractor.dart';
import 'package:pzz/domain/error/standard_pzz_error.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/dto/basket_dto.dart';
import 'package:pzz/models/dto/sause_dto.dart';
import 'package:pzz/models/mappers/address_response_mapper.dart';
import 'package:pzz/models/mappers/basket_item_response_mapper.dart';
import 'package:pzz/models/mappers/pizza_item_response_mapper.dart';
import 'package:pzz/models/mappers/sause_item_response_mapper.dart';
import 'package:pzz/models/payment_way.dart';
import 'package:pzz/models/person_info/house.dart';
import 'package:pzz/models/person_info/personal_info.dart';
import 'package:pzz/models/person_info/street.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/utils/house_comparator.dart';

class PzzNetService {
  PzzNetService(this.client);

  final baseUrl = Uri.parse('https://pzz.by/api/v1/');

  final http.Client client;

  Future<List<Pizza>> loadPizzas() async {
    const path = 'pizzas?load=ingredients,filters&filter=meal_only:0&order=position:asc';
    return client.get(baseUrl.resolve(path)).handleResponse(_pizzaResponseMapper);
  }

  Future<List<Sauce>> loadSauces() {
    const path = 'sauces?order=title:asc';
    return client.get(baseUrl.resolve(path)).handleResponse(_sauceResponseMapper);
  }

  Future<BasketEntity> loadBasket() async {
    const path = 'basket';
    return client.get(baseUrl.resolve(path)).handleResponse(_basketResponseMapper);
  }

  Future<BasketEntity> addProductToBasket(Product product) async {
    const path = 'basket/add-item';
    final formData = _makeProductFormData(product);
    return client.post(baseUrl.resolve(path), body: formData).handleResponse(_basketResponseMapper);
  }

  Future<BasketEntity> removePizzaFromBasket(Product product) async {
    const path = 'basket/remove-item';
    final formData = _makeProductFormData(product);
    return client.post(baseUrl.resolve(path), body: formData).handleResponse(_basketResponseMapper);
  }

  Future<List<Street>> searchStreet(String query) async {
    final path = Uri.encodeFull('streets.json?order=title:asc&search=title:$query');
    return client.get(baseUrl.resolve(path)).handleResponse(_searchedStreetResponseMapper);
  }

  Future<List<House>> loadHousesByStreet(int streetId) async {
    final path = Uri.encodeFull('streets.json/$streetId?order=title:asc&load=region.pizzeria');
    return client.get(baseUrl.resolve(path)).handleResponse(_houseResponseMapper);
  }

  Future<BasketEntity> updateAddress(PersonalInfo personalInfo) async {
    await Future.delayed(const Duration(seconds: 1));
    const path = 'basket/update-address';
    return client
        .post(
          baseUrl.resolve(path),
          body: _makePersonalInfoFormData(personalInfo),
        )
        .handleResponse(_basketResponseMapper);
  }

  Future<void> placeOrder() async {
    await Future.delayed(const Duration(seconds: 3));
    // final path = 'basket/save';
    // return client.post(baseUrl.resolve(path)).handleResponse(_basketResponseMapper);
  }

  List<Pizza> _pizzaResponseMapper(dynamic data) {
    return (data as Iterable).map(PizzaItemResponseMapper.map).toList(growable: false);
  }

  List<Street> _searchedStreetResponseMapper(dynamic data) {
    return (data as Iterable).map((item) {
      return Street(
        id: item['id'] as int,
        title: item['title'] as String,
      );
    }).toList(growable: false);
  }

  List<House> _houseResponseMapper(dynamic data) {
    return (data as Iterable).map((item) {
      return House(
        id: item['id'] as int,
        title: item['title'] as String,
      );
    }).toList(growable: false)
      ..sort(compareHouse);
  }

  List<Sauce> _sauceResponseMapper(dynamic data) {
    return (data as Iterable)
        .map((e) => SauceDto.fromJson(e as Map<String, dynamic>))
        .map(SauceItemResponseMapper.map)
        .toList(growable: false);
  }

  BasketEntity _basketResponseMapper(dynamic data) {
    final basketDto = BasketDto.fromJson(data as Map<String, dynamic>);
    final products = basketDto.items.map(BasketItemResponseMapper.map).toList(growable: false);
    return BasketEntity(
      items: products,
      totalAmount: basketDto.total! / 10000,
      address: AddressResponseMapper.map(basketDto.address!),
    );
  }

  Map<String, dynamic> _makeProductFormData(Product product) {
    // CRUTCH for back end, this props non nullable only for pizzas and hardcoded as 'thin'
    final String? dough = product.type == ProductType.pizza ? 'thin' : null;
    return <String, String>{
      'id': '${product.id}',
      'type': product.type.name,
      // if it null send 'null' string
      // ignore: unnecessary_string_interpolations
      'size': '${product.size?.name}',
      // ignore: unnecessary_string_interpolations
      'dough': '$dough',
    };
  }
}

Map<String, dynamic> _makePersonalInfoFormData(PersonalInfo personalInfo) {
  return {
    'name': personalInfo.name,
    'flat': personalInfo.flat,
    'entrance': personalInfo.entrance,
    'floor': personalInfo.floor,
    'intercom': personalInfo.intercom,
    'comment': personalInfo.comment,
    'preorder_datetime': '',
    'no-contact-delivery': '1',
    'renting': personalInfo.renting,
    'phone': personalInfo.phone,
    'preorder_date': '',
    'preorder_time': '',
    'no_contact_delivery': '0',
    'street': personalInfo.street,
    'house': personalInfo.house,
    'payment': personalInfo.paymentWay!.name
  };
}

extension on Future<http.Response> {
  Future<T> handleResponse<T>(T Function(dynamic data) mapper) {
    return then((response) {
      final body = jsonDecode(response.body) as Map<String, dynamic>?;
      if (response.statusCode == 200) {
        // I'm not sure if the error can be true with code 200
        // But for a restful sleep I will add:)
        if (body!['error'] == false) {
          final data = body['response']['data'];
          return mapper(data);
        } else {
          throw PzzServerError.fromJson(body);
        }
      } else {
        throw PzzServerError.fromJson(body!);
      }
    }).catchError((Object ex, StackTrace stackTrace) {
      debugPrint(ex.toString());
      debugPrintStack(stackTrace: stackTrace);
      throw PzzServerError(errorMessageExtractor(ex));
    });
  }
}
