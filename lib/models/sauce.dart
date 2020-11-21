import 'package:flutter/cupertino.dart';
import 'package:pzz/models/pizza.dart';

@immutable
class Sauce {
  final int id;
  final String title;
  final String photo;
  final num price;

  const Sauce({
    @required this.id,
    @required this.title,
    @required this.photo,
    @required this.price,
  })  : assert(id != null),
        assert(title != null),
        assert(price != null);

  ProductType get type => ProductType.sauce;

  String get priceText => '${price.toStringAsFixed(2)} р.';

  @override
  String toString() {
    return 'SauceDto{id: $id, title: $title, photo: $photo, price: $price}';
  }
}
