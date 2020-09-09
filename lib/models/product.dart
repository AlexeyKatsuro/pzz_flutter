import 'package:flutter/material.dart';
import 'package:pzz/models/pizza.dart';

@immutable
class Product {
  final int id;
  final ProductSize size;
  final ProductType type;
  final num price;

  const Product({
    @required this.id,
    @required this.type,
    @required this.price,
    this.size,
  })  : assert(id != null),
        assert(price != null),
        assert(type != null);
}
