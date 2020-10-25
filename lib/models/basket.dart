import 'package:flutter/cupertino.dart';
import 'package:pzz/models/basket_address.dart';
import 'package:pzz/models/basket_product.dart';

@immutable
class Basket {
  const Basket({
    @required this.items,
    @required this.totalAmount,
    @required this.address,
  });

  const Basket.initial({
    this.items = const [],
    this.totalAmount = 0,
    this.address = const BasketAddress.initial(),
  });

  //final BasketDto data;

  final List<BasketProduct> items;
  final num totalAmount;
  final BasketAddress address;

  String get totalAmountText => '${totalAmount.toStringAsFixed(2)} р.';
}
