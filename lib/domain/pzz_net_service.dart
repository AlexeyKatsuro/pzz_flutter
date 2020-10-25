import 'dart:convert';

import 'package:http/http.dart' as http;
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

class PzzNetService {
  final baseUrl = 'https://pzz.by/api/v1/';

  PzzNetService(this.client);

  final http.Client client;

  Future<List<Pizza>> loadPizzas() async {
    final path = 'pizzas?load=ingredients,filters&filter=meal_only:0&order=position:asc';
    return client.get(baseUrl + path).handleResponse(_pizzaResponseMapper);
  }

  Future<List<Sauce>> loadSauces() {
    final path = 'sauces?order=title:asc';
    return client.get(baseUrl + path).handleResponse(_sauceResponseMapper);
  }

  Future<Basket> loadBasket() async {
    final path = 'basket';
    return client.get(baseUrl + path).handleResponse(_basketResponseMapper);
  }

  Future<Basket> addProductToBasket(Product product) async {
    final path = 'basket/add-item';
    final formData = _makeProductFormData(product);
    return client.post(baseUrl + path, body: formData).handleResponse(_basketResponseMapper);
  }

  Future<Basket> removePizzaFromBasket(Product product) async {
    final path = 'basket/remove-item';
    final formData = _makeProductFormData(product);
    return client.post(baseUrl + path, body: formData).handleResponse(_basketResponseMapper);
  }

  Future<List<Street>> searchStreet(String query) async {
    final path = Uri.encodeFull('streets?order=title:asc&search=title:$query');
    return client.get(baseUrl + path).handleResponse(_searchedStreetResponseMapper);
  }

  Future<List<House>> loadHousesByStreet(int streetId) async {
    final path = Uri.encodeFull('streets/$streetId?order=title:asc&load=region.pizzeria');
    return client.get(baseUrl + path).handleResponse(_houseResponseMapper);
  }

  Future<Basket> updateAddress(PersonalInfo personalInfo) async {
    final path = 'basket/update-address';
    return client
        .post(
          baseUrl + path,
          body: _makePersonalInfoFormData(personalInfo),
        )
        .handleResponse(_basketResponseMapper);
  }

  Future<Basket> placeOrder() async {
    await Future.delayed(Duration(seconds: 3));
    throw "TODO";
    final path = 'basket/save';
    return client.post(baseUrl + path).handleResponse(_basketResponseMapper);
  }

  List<Pizza> _pizzaResponseMapper(dynamic data) {
    return (data as Iterable).map(PizzaItemResponseMapper.map).toList(growable: false);
  }

  List<Street> _searchedStreetResponseMapper(dynamic data) {
    return (data as Iterable).map((item) {
      return Street(
        id: item['id'],
        title: item['title'],
      );
    }).toList(growable: false);
  }

  List<House> _houseResponseMapper(dynamic data) {
    return (data as Iterable).map((item) {
      return House(
        id: item['id'],
        title: item['title'],
      );
    }).toList(growable: false);
  }

  List<Sauce> _sauceResponseMapper(dynamic data) {
    return (data as Iterable).map((e) => SauceDto.fromJson(e)).map(SauceItemResponseMapper.map).toList(growable: false);
  }

  Basket _basketResponseMapper(dynamic data) {
    final basketDto = BasketDto.fromJson(data);
    final products = basketDto.items.map(BasketItemResponseMapper.map).toList(growable: false);
    return Basket(
      items: products,
      totalAmount: basketDto.total / 10000,
      address: AddressResponseMapper.map(basketDto.address),
    );
  }

  Map<String, dynamic> _makeProductFormData(Product product) {
    // CRUTCH for back end, this props non nullable only for pizzas and hardcoded as 'thin'
    final String dough = product.type == ProductType.pizza ? 'thin' : null;
    return {
      'id': '${product.id}',
      'type': '${product.type.name}',
      'size': '${product.size?.name}',
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
    'payment': personalInfo.paymentWay.name
  };
}

extension on Future<http.Response> {
  Future<T> handleResponse<T>(T Function(dynamic data) mapper) {
    return then((response) {
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['error'] == false) {
          final data = body['response']['data'];
          return mapper(data);
        } else {
          print(body['data']);
        }
      }
    }).catchError((ex, StackTrace stackTrace) {
      print(ex);
      print(stackTrace);
    });
  }
}
