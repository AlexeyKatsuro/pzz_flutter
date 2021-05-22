import 'package:flutter/cupertino.dart';
import 'package:pzz/models/pizza.dart';

@immutable
class Sauce {
  const Sauce({
    required this.id,
    required this.title,
    required this.photo,
    required this.price,
  });

  final int id;
  final String title;
  final String photo;
  final num price;

  ProductType get type => ProductType.sauce;

  String get priceText => '${price.toStringAsFixed(2)} р.';

  @override
  String toString() {
    return 'SauceDto{id: $id, title: $title, photo: $photo, price: $price}';
  }
}
