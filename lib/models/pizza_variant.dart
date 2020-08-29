import 'package:flutter/cupertino.dart';
import 'package:pzz/models/pizza.dart';

@immutable
class PizzaVariant {
  final PizzaSize size;
  final num price;
  final String weight;
  final String diameter;

  PizzaVariant({
    @required this.size,
    @required this.price,
    @required this.weight,
    @required this.diameter,
  })  : assert(size != null),
        assert(price != null),
        assert(weight != null),
        assert(diameter != null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PizzaVariant &&
          runtimeType == other.runtimeType &&
          size == other.size &&
          price == other.price &&
          weight == other.weight &&
          diameter == other.diameter;

  @override
  int get hashCode => size.hashCode ^ price.hashCode ^ weight.hashCode ^ diameter.hashCode;

  @override
  String toString() {
    return 'PizzaVariant{size: $size, price: $price, weight: $weight, diameter: $diameter}';
  }
}
