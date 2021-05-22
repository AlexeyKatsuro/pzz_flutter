import 'package:flutter/cupertino.dart';
import 'package:pzz/models/payment_way.dart';

@immutable
class PersonalInfo {
  const PersonalInfo({
    this.name = '',
    this.phone = '',
    this.streetId = 0,
    this.houseId = 0,
    this.street = '',
    this.house = '',
    this.flat = '',
    this.entrance = '',
    this.floor = '',
    this.intercom = '',
    this.comment = '',
    this.paymentWay,
    this.renting = '',
  });

  final String name;
  final String phone;
  final int streetId;
  final int houseId;
  final String street;
  final String house;
  final String flat;
  final String entrance;
  final String floor;
  final String intercom;
  final String comment;
  final PaymentWay? paymentWay;
  final String renting;

  PersonalInfo copyWith({
    String? name,
    String? phone,
    int? streetId,
    int? houseId,
    String? street,
    String? house,
    String? flat,
    String? entrance,
    String? floor,
    String? intercom,
    String? comment,
    PaymentWay? paymentWay,
    String? renting,
  }) {
    return PersonalInfo(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      streetId: streetId ?? this.streetId,
      houseId: houseId ?? this.houseId,
      street: street ?? this.street,
      house: house ?? this.house,
      flat: flat ?? this.flat,
      entrance: entrance ?? this.entrance,
      floor: floor ?? this.floor,
      intercom: intercom ?? this.intercom,
      comment: comment ?? this.comment,
      paymentWay: paymentWay ?? this.paymentWay,
      renting: renting ?? this.renting,
    );
  }
}
