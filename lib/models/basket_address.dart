import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@immutable
class BasketAddressEntity {
  const BasketAddressEntity({
    required this.streetId,
    required this.houseId,
    required this.name,
    required this.phone,
    required this.street,
    required this.house,
    required this.flat,
    required this.entrance,
    required this.floor,
    required this.intercom,
  });

  const BasketAddressEntity.initial({
    this.streetId = 0,
    this.houseId = 0,
    this.name = '',
    this.phone = '',
    this.street = '',
    this.house = '',
    this.flat = '',
    this.entrance = '',
    this.floor = '',
    this.intercom = '',
  });

  final int streetId;

  final int houseId;

  final String name;

  final String phone;

  final String street;

  final String house;

  final String flat;

  final String entrance;

  final String floor;

  final String intercom;
}

extension BasketAddressExt on BasketAddressEntity {
  String makeFullAddress(AppLocalizations localizations) {
    if (flat.isNotEmpty) {
      return localizations.streetHouseFlat(street, house, flat);
    } else {
      return localizations.streetHouse(street, house);
    }
  }
}
