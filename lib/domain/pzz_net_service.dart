import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:pzz/domain/cookie_interseptor.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/dto/basket_dto.dart';
import 'package:pzz/models/mappers/pizza_item_response_mapper.dart';
import 'package:pzz/models/pizza.dart';

class PzzNetService {
  final baseUrl = 'https://pzz.by/api/v1/';

  http.Client client = HttpClientWithInterceptor.build(interceptors: [
    SessionCookiesInterceptor(),
    //   LoggingInterceptor(),
  ]);

  Future<List<Pizza>> loadPizzas() async {
    final path = 'pizzas?load=ingredients,filters&filter=meal_only:0&order=position:asc';
    return client.get(baseUrl + path).then((response) {
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['error'] == false) {
          return _pizzaResponseMapper(body['response']);
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
    final response = await client.get(baseUrl + path);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body['error'] == false) {
        final basketDto = BasketDto.fromJson(body['response']['data']);
        return Basket(basketDto);
      } else {
        print(body['data']);
      }
    }
  }

  Future<Basket> addPizzaItem(Pizza pizza, PizzaSize size) async {
    final path = 'basket/add-item';
    final formData = {
      'id': '${pizza.id}',
      'type': 'pizza',
      'size': '${size.name}',
      'dough': 'thin',
    };
    return client.post(baseUrl + path, body: formData).then((response) {
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['error'] == false) {
          final basketDto = BasketDto.fromJson(body['response']['data']);
          return Basket(basketDto);
        } else {
          print(body['data']);
        }
      }
    }).catchError((ex, StackTrace stackTrace) {
      print(ex);
      print(stackTrace);
    });
  }

  List<Pizza> _pizzaResponseMapper(dynamic response) {
    Iterable data = response['data'];
    return data.map(PizzaItemResponseMapper.map).toList();
  }
}
