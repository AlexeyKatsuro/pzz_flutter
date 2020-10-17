import 'package:pzz/models/payment_way.dart';
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

extension PaymentWayLocalExt on PaymentWay {
  String get localized {
    switch (this) {
      case PaymentWay.charge:
        return StringRes.charge;
      case PaymentWay.cash:
        return StringRes.cash;
      case PaymentWay.online:
        return StringRes.online;
      case PaymentWay.halva:
        return StringRes.halva;
    }
    assert(false);
    return null;
  }
}
