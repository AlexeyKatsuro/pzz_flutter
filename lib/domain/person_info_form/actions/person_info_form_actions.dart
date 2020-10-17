 import 'package:pzz/models/payment_way.dart';

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
