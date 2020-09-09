import 'package:flutter/cupertino.dart';
import 'package:pzz/models/pizza.dart';

@immutable
class BasketProduct {
  final int id;
  final String title;
  final ProductType type;
  final ProductSize size;
  final num price;

  const BasketProduct({
    @required this.id,
    @required this.type,
    @required this.title,
    this.size,
    this.price,
  })  : assert(id != null),
        assert(type != null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasketProduct &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          type == other.type &&
          size == other.size &&
          price == other.price;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ type.hashCode ^ size.hashCode ^ price.hashCode;

  @override
  String toString() {
    return 'BasketProduct{id: $id, title: $title, type: $type, size: $size, price: $price}';
  }
}
