// ignore_for_file: avoid_dynamic_calls

import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/pizza_variant.dart';

class PizzaItemResponseMapper {
  static Pizza map(dynamic from) {
    return Pizza(
      id: from['id'] as int,
      name: from['title'] as String,
      description: from['anonce'] as String,
      thumbnail: from['photo_small'] as String,
      photo: from['photo1'] as String,
      variants: _mapVariants(from),
    );
  }

  static List<PizzaVariant> _mapVariants(from) {
    final List<PizzaVariant> variants = [];
    if (from['is_big'] == 1) {
      variants.add(_mapVariantsData(from, ProductSize.big));
    }
    if (from['is_medium'] == 1) {
      variants.add(_mapVariantsData(from, ProductSize.medium));
    }
    if (from['is_thin'] == 1) {
      variants.add(_mapVariantsData(from, ProductSize.thin));
    }
    return variants;
  }

  static PizzaVariant _mapVariantsData(from, ProductSize size) => PizzaVariant(
        size: size,
        weight: from['${size.name}_weight'] as String,
        diameter: from['${size.name}_diameter'] as String,
        price: (from['${size.name}_price'] as int? ?? 0) / 10000,
      );
}
