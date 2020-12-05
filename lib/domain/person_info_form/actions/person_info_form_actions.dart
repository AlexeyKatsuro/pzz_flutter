import 'package:flutter/foundation.dart';
import 'package:pzz/models/payment_way.dart';
import 'package:pzz/models/person_info/house.dart';
import 'package:pzz/models/person_info/personal_info.dart';
import 'package:pzz/models/person_info/street.dart';
import 'package:pzz/utils/scoped.dart';

class PerformStreetSearchAction implements Scoped {
  final String query;
  final String scope;

  PerformStreetSearchAction({@required this.query, @required this.scope});
}

class PerformHouseSearchAction {
  final String query;

  PerformHouseSearchAction(this.query);
}

class SearchStreetResultAction {
  final List<Street> streets;

  SearchStreetResultAction(this.streets);
}

class CancelStreetSearchAction {}

class SelectStreetAction {
  final Street street;

  SelectStreetAction(this.street);
}

class LoadHousesAction implements Scoped {
  final int streetId;
  final String scope;

  LoadHousesAction({@required this.streetId, @required this.scope});
}

class LoadedHouseAction {
  final List<House> houses;

  LoadedHouseAction(this.houses);
}

class SelectHouseAction {
  final House house;

  SelectHouseAction(this.house);
}

class SavePersonalInfoAction {
  final PersonalInfo info;

  SavePersonalInfoAction(this.info);
}

class NameChangedAction {
  const NameChangedAction(this.text);

  final String text;
}

class PhoneChangedAction {
  const PhoneChangedAction(this.text);

  final String text;
}

class StreetChangedAction {
  const StreetChangedAction(this.text);

  final String text;
}

class HouseChangedAction {
  const HouseChangedAction(this.text);

  final String text;
}

class FlatChangedAction {
  const FlatChangedAction(this.text);

  final String text;
}

class EntranceChangedAction {
  const EntranceChangedAction(this.text);

  final String text;
}

class FloorChangedAction {
  const FloorChangedAction(this.text);

  final String text;
}

class IntercomChangedAction {
  const IntercomChangedAction(this.text);

  final String text;
}

class CommentChangedAction {
  const CommentChangedAction(this.text);

  final String text;
}

class PaymentWayChangedAction {
  const PaymentWayChangedAction(this.paymentWay);

  final PaymentWay paymentWay;
}

class RentingChangedAction {
  const RentingChangedAction(this.text);

  final String text;
}
