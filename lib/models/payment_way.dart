import 'package:flutter/foundation.dart';

enum PaymentWay {
  charge,
  cash,
  online,
  halva,
}

extension PaymentWayExt on PaymentWay {
  String get name => describeEnum(this);
}
