import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:pzz/models/payment_way.dart';
import 'package:pzz/models/pizza.dart';

extension ProductSizeLocalExt on ProductSize {
  static ProductSize fromString(String size) {
    final sizeEnum = fromStringOrNull(size);
    return sizeEnum!;
  }

  static ProductSize? fromStringOrNull(String size) {
    final sizeEnum = ProductSize.values.firstWhereOrNull((element) => element.name == size);
    return sizeEnum;
  }

  String localized(AppLocalizations localizations) {
    switch (this) {
      case ProductSize.big:
        return localizations.pizzaSizeBig;
      case ProductSize.medium:
        return localizations.pizzaSizeMedium;
      case ProductSize.thin:
        return localizations.pizzaSizeThin;
    }
  }
}

extension ProductTypeLocalExt on ProductType {
  String localizedPlurals(AppLocalizations localizations) {
    switch (this) {
      case ProductType.pizza:
        return localizations.pizzas;
      case ProductType.sauce:
        return localizations.sauces;
      case ProductType.snack:
        return localizations.snacks;
      case ProductType.dessert:
        return localizations.desserts;
      case ProductType.drink:
        return localizations.drinks;
    }
  }
}

extension PaymentWayLocalExt on PaymentWay {
  String localized(AppLocalizations localizations) {
    switch (this) {
      case PaymentWay.charge:
        return localizations.charge;
      case PaymentWay.cash:
        return localizations.cash;
      case PaymentWay.online:
        return localizations.online;
      case PaymentWay.halva:
        return localizations.halva;
    }
  }
}
