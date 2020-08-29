import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pzz/models/mappers/pizza_item_response_mapper.dart';
import 'package:pzz/models/pizza.dart';

class PzzNetService {
  final baseUrl = 'https://pzz.by/api/v1/';

  Future<List<Pizza>> loadPizzas() async {
    final path = 'pizzas?load=ingredients,filters&filter=meal_only:0&order=position:asc';

    final response = await http.get(baseUrl + path);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body['error'] == false) {
        return _pizzaResponseMapper(body['response']);
      } else {
        print(body['data']);
      }
    }
  }

  List<Pizza> _pizzaResponseMapper(dynamic response) {
    Iterable data = response['data'];
    return data.map(PizzaItemResponseMapper.map).toList();
  }
}
