import 'package:flutter/cupertino.dart';
import 'package:pzz/models/dto/basket_dto.dart';
import 'package:pzz/models/dto/basket_item_dto.dart';

@immutable
class Basket {
  const Basket(this.data);

  final BasketDto data;

  List<BasketItemDto> get items => data.items;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Basket && runtimeType == other.runtimeType && data == other.data;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() {
    return 'Basket{data: $data}';
  }
}
