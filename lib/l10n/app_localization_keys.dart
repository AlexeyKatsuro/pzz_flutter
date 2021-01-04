import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pzz/utils/UiMessage.dart';

enum AppLocalizationKeys {
  appName,
  pizzaSizeBig,
  pizzaSizeMedium,
  pizzaSizeThin,
  inBasket,
  basket,
  totalPrice,
  deliveryAddress,
  yourName,
  yourPhoneNumber,
  street,
  house,
  flat,
  entrance,
  floor,
  intercom,
  commentsToOrder,
  save,
  search,
  repeat,
  addSauces,
  pizzas,
  sauces,
  snacks,
  desserts,
  drinks,
  payment_way,
  charge,
  cash,
  online,
  halva,
  prepareToCharge,
  placeOrder,
  errorEmptyPhone,
  errorEmptyStreet,
  errorEmptyHome,
  errorEmptyPaymentPay,
  errorConnection,
  errorUnexpected,
  error404,
  error404Message,
  toConfirmTitle,
  toConfirmPhone,
  toConfirmAddress,
  toConfirmButton,
  toConfirmTotalPrice,
  streetHouse,
  streetHouseFlat,
  chooseFeeSauces,
}

extension AppLocalizationKeysExt on AppLocalizationKeys {
  String localized(AppLocalizations localization, [Map<String, dynamic> params]) {
    switch (this) {
      case AppLocalizationKeys.appName:
        return localization.appName;
      case AppLocalizationKeys.pizzaSizeBig:
        return localization.pizzaSizeBig;
      case AppLocalizationKeys.pizzaSizeMedium:
        return localization.pizzaSizeMedium;
      case AppLocalizationKeys.pizzaSizeThin:
        return localization.pizzaSizeThin;
      case AppLocalizationKeys.inBasket:
        return localization.inBasket;
      case AppLocalizationKeys.basket:
        return localization.basket;
      case AppLocalizationKeys.totalPrice:
        return localization.totalPrice(params['cost']);
      case AppLocalizationKeys.deliveryAddress:
        return localization.deliveryAddress;
      case AppLocalizationKeys.yourName:
        return localization.yourName;
      case AppLocalizationKeys.yourPhoneNumber:
        return localization.yourPhoneNumber;
      case AppLocalizationKeys.street:
        return localization.street;
      case AppLocalizationKeys.house:
        return localization.house;
      case AppLocalizationKeys.flat:
        return localization.flat;
      case AppLocalizationKeys.entrance:
        return localization.entrance;
      case AppLocalizationKeys.floor:
        return localization.floor;
      case AppLocalizationKeys.intercom:
        return localization.intercom;
      case AppLocalizationKeys.commentsToOrder:
        return localization.commentsToOrder;
      case AppLocalizationKeys.save:
        return localization.save;
      case AppLocalizationKeys.search:
        return localization.search;
      case AppLocalizationKeys.repeat:
        return localization.repeat;
      case AppLocalizationKeys.addSauces:
        return localization.addSauces;
      case AppLocalizationKeys.pizzas:
        return localization.pizzas;
      case AppLocalizationKeys.sauces:
        return localization.sauces;
      case AppLocalizationKeys.snacks:
        return localization.snacks;
      case AppLocalizationKeys.desserts:
        return localization.desserts;
      case AppLocalizationKeys.drinks:
        return localization.drinks;
      case AppLocalizationKeys.payment_way:
        return localization.payment_way;
      case AppLocalizationKeys.charge:
        return localization.charge;
      case AppLocalizationKeys.cash:
        return localization.cash;
      case AppLocalizationKeys.online:
        return localization.online;
      case AppLocalizationKeys.halva:
        return localization.halva;
      case AppLocalizationKeys.prepareToCharge:
        return localization.prepareToCharge;
      case AppLocalizationKeys.placeOrder:
        return localization.placeOrder;
      case AppLocalizationKeys.errorEmptyPhone:
        return localization.errorEmptyPhone;
      case AppLocalizationKeys.errorEmptyStreet:
        return localization.errorEmptyStreet;
      case AppLocalizationKeys.errorEmptyHome:
        return localization.errorEmptyHome;
      case AppLocalizationKeys.errorEmptyPaymentPay:
        return localization.errorEmptyPaymentPay;
      case AppLocalizationKeys.errorConnection:
        return localization.errorConnection;
      case AppLocalizationKeys.errorUnexpected:
        return localization.errorUnexpected;
      case AppLocalizationKeys.error404:
        return localization.error404;
      case AppLocalizationKeys.error404Message:
        return localization.error404Message;
      case AppLocalizationKeys.toConfirmTitle:
        return localization.toConfirmTitle;
      case AppLocalizationKeys.toConfirmPhone:
        return localization.toConfirmPhone;
      case AppLocalizationKeys.toConfirmAddress:
        return localization.toConfirmAddress;
      case AppLocalizationKeys.toConfirmButton:
        return localization.toConfirmButton;
      case AppLocalizationKeys.toConfirmTotalPrice:
        return localization.toConfirmTotalPrice;
      case AppLocalizationKeys.streetHouse:
        return localization.streetHouse(params['street'], params['house']);
      case AppLocalizationKeys.streetHouseFlat:
        return localization.streetHouseFlat(params['street'], params['house'], params['flat']);
      case AppLocalizationKeys.chooseFeeSauces:
        return localization.chooseFeeSauces(params['count']);
    }
    assert(false);
    return null;
  }

  UiMessage asMessage([Map<String, dynamic> param]) => UiMessage.key(this, param);
}
