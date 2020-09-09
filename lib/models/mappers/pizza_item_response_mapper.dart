import 'package:pzz/models/pizza_variant.dart';

import '../pizza.dart';

class PizzaItemResponseMapper {
  static Pizza map(dynamic from) {
    return Pizza(
      id: from['id'],
      name: from['title'],
      description: from['anonce'],
      thumbnail: from['photo_small'],
      photo: from['photo1'],
      variants: _mapVariants(from),
    );
  }

  static List<PizzaVariant> _mapVariants(from) {
    final List<PizzaVariant> variants = [];
    if (from['is_big'] == 1) variants.add(_mapVariantsData(from, ProductSize.big));
    if (from['is_medium'] == 1) variants.add(_mapVariantsData(from, ProductSize.medium));
    if (from['is_thin'] == 1) variants.add(_mapVariantsData(from, ProductSize.thin));
    return variants;
  }

  static PizzaVariant _mapVariantsData(from, ProductSize size) => PizzaVariant(
      size: size,
      weight: from['${size.name}_weight'],
      diameter: from['${size.name}_diameter'],
      price: (from['${size.name}_price'] ?? 0) / 10000);
}
