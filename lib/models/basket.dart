import 'package:flutter/cupertino.dart';
import 'package:pzz/models/basket_address.dart';
import 'package:pzz/models/basket_product.dart';

@immutable
class BasketEntity {
  const BasketEntity({
    required this.items,
    required this.totalAmount,
    required this.address,
  });

  const BasketEntity.initial({
    this.items = const [],
    this.totalAmount = 0,
    this.address = const BasketAddressEntity.initial(),
  });

  //final BasketDto data;

  final List<BasketProduct> items;
  final num totalAmount;
  final BasketAddressEntity address;

  String get totalAmountText => '${totalAmount.toStringAsFixed(2)} р.';

  BasketEntity copyWith({
    List<BasketProduct>? items,
    num? totalAmount,
    BasketAddressEntity? address,
  }) {
    return BasketEntity(
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      address: address ?? this.address,
    );
  }
}
