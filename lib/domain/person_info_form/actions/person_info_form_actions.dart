import 'package:pzz/models/payment_way.dart';
import 'package:pzz/models/person_info/house.dart';
import 'package:pzz/models/person_info/personal_info.dart';
import 'package:pzz/models/person_info/street.dart';
import 'package:pzz/utils/scoped.dart';

class PerformStreetSearchAction implements Scoped {
  PerformStreetSearchAction({required this.query, required this.scope});

  final String query;
  @override
  final String scope;
}

class PerformHouseSearchAction {
  PerformHouseSearchAction(this.query);

  final String query;
}

class SearchStreetResultAction {
  SearchStreetResultAction(this.streets);

  final List<Street> streets;
}

class CancelStreetSearchAction {}

class SelectStreetAction {
  SelectStreetAction(this.street);

  final Street street;
}

class LoadHousesAction implements Scoped {
  LoadHousesAction({required this.streetId, required this.scope});

  final int streetId;

  @override
  final String scope;
}

class LoadedHouseAction {
  LoadedHouseAction(this.houses);

  final List<House> houses;
}

class SelectHouseAction {
  SelectHouseAction(this.house);

  final House house;
}

class SavePersonalInfoAction {
  SavePersonalInfoAction(this.info);

  final PersonalInfo info;
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
