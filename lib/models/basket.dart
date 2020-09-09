import 'package:flutter/cupertino.dart';
import 'package:pzz/models/basket_product.dart';

@immutable
class Basket {
  const Basket(this.items);

  //final BasketDto data;

  final List<BasketProduct> items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Basket && runtimeType == other.runtimeType && items == other.items;

  @override
  int get hashCode => items.hashCode;
}
