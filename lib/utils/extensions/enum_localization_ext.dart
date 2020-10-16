import 'package:pzz/models/pizza.dart';
import 'package:pzz/res/strings.dart';

extension ProductSizeLocalExt on ProductSize {
  static Map<ProductSize, String> _localizedMap = {
    ProductSize.big: StringRes.pizza_size_big,
    ProductSize.medium: StringRes.pizza_size_medium,
    ProductSize.thin: StringRes.pizza_size_thin
  };

  static ProductSize fromString(String size) {
    final sizeEnum = fromStringOrNull(size);
    assert(sizeEnum != null);
    return sizeEnum;
  }

  static ProductSize fromStringOrNull(String size) {
    final sizeEnum = ProductSize.values.firstWhere((element) => element.name == size);
    return sizeEnum;
  }

  String get localizedString => ProductSizeLocalExt._localizedMap[this];
}

extension ProductTypeLocalExt on ProductType {
  String get localizedPluralsString {
    switch (this) {
      case ProductType.pizza:
        return StringRes.pizzas;
      case ProductType.sauce:
        return StringRes.sauces;
      case ProductType.snack:
        return StringRes.snacks;
      case ProductType.dessert:
        return StringRes.desserts;
      case ProductType.drink:
        return StringRes.drinks;
    }
    assert(false);
    return null;
  }
}
