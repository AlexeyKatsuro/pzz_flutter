import 'package:flutter/foundation.dart';

@immutable
class PersonalInfoErrors {
  final String phone;
  final String street;
  final String house;
  final String paymentWay;

  const PersonalInfoErrors({
    this.phone = '',
    this.street = '',
    this.house = '',
    this.paymentWay = '',
  });

  PersonalInfoErrors copyWith({
    String phone,
    String street,
    String house,
    String paymentWay,
  }) {
    return PersonalInfoErrors(
      phone: phone ?? this.phone,
      street: street ?? this.street,
      house: house ?? this.house,
      paymentWay: paymentWay ?? this.paymentWay,
    );
  }

  bool get hasErrors => phone.isNotEmpty || street.isNotEmpty || house.isNotEmpty || paymentWay.isNotEmpty;
}
