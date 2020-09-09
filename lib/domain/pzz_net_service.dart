import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/dto/basket_dto.dart';
import 'package:pzz/models/mappers/basket_item_response_mapper.dart';
import 'package:pzz/models/mappers/pizza_item_response_mapper.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';

class PzzNetService {
  final baseUrl = 'https://pzz.by/api/v1/';

  PzzNetService(this.client);

  final http.Client client;

  Future<List<Pizza>> loadPizzas() async {
    final path = 'pizzas?load=ingredients,filters&filter=meal_only:0&order=position:asc';
    return client.get(baseUrl + path).then((response) {
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['error'] == false) {
          final data = body['response']['data'];
          return _pizzaResponseMapper(data);
        } else {
          print(body['data']);
        }
      }
    }).catchError((ex, StackTrace stackTrace) {
      print(ex);
      print(stackTrace);
    });
  }

  Future<Basket> loadBasket() async {
    final path = 'basket';
    return client.get(baseUrl + path).then((response) {
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['error'] == false) {
          final data = body['response']['data'];
          return _basketResponseMapper(data);
        } else {
          print(body['data']);
        }
      }
    }).catchError((ex, StackTrace stackTrace) {
      print(ex);
      print(stackTrace);
    });
  }

  Future<Basket> addProductToBasket(Product product) async {
    final path = 'basket/add-item';
    final formData = makeFormData(product);
    return client.post(baseUrl + path, body: formData).then((response) {
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['error'] == false) {
          final data = body['response']['data'];
          return _basketResponseMapper(data);
        } else {
          print(body['data']);
        }
      }
    }).catchError((ex, StackTrace stackTrace) {
      print(ex);
      print(stackTrace);
    });
  }

  Future<Basket> removePizzaFromBasket(Product product) async {
    final path = 'basket/remove-item';
    final formData = makeFormData(product);
    return client.post(baseUrl + path, body: formData).then((response) {
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['error'] == false) {
          final data = body['response']['data'];
          return _basketResponseMapper(data);
        } else {
          print(body['data']);
        }
      }
    }).catchError((ex, StackTrace stackTrace) {
      print(ex);
      print(stackTrace);
    });
  }

  List<Pizza> _pizzaResponseMapper(dynamic data) {
    return (data as Iterable).map(PizzaItemResponseMapper.map).toList(growable: false);
  }

  Basket _basketResponseMapper(dynamic data) {
    final basketDto = BasketDto.fromJson(data);
    return Basket(basketDto.items.map(BasketItemResponseMapper.map).toList(growable: false));
  }

  Map<String, dynamic> makeFormData(Product product) {
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

extension<T> on Future<http.Response> {
  Future<T> handleResponse(T Function(dynamic) mapper) {
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
