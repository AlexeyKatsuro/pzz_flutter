import 'package:flutter/cupertino.dart';
import 'package:pzz/models/basket_product.dart';

@immutable
class Basket {
  const Basket({this.items = const [], this.totalAmount = 0});

  //final BasketDto data;

  final List<BasketProduct> items;
  final num totalAmount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Basket && runtimeType == other.runtimeType && items == other.items;

  @override
  int get hashCode => items.hashCode;
}
