import 'package:flutter/foundation.dart';
import 'package:pzz/utils/UiMessage.dart';

import '../../utils/UiMessage.dart';

@immutable
class PersonalInfoErrors {
  final UiMessage phone;
  final UiMessage street;
  final UiMessage house;
  final UiMessage paymentWay;

  const PersonalInfoErrors({
    this.phone = const UiMessageEmpty(),
    this.street =const UiMessageEmpty(),
    this.house =const UiMessageEmpty(),
    this.paymentWay =const UiMessageEmpty(),
  });

  PersonalInfoErrors copyWith({
    UiMessage phone,
    UiMessage street,
    UiMessage house,
    UiMessage paymentWay,
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
