import 'package:flutter/material.dart';
import 'package:pzz/models/payment_way.dart';
import 'package:pzz/utils/extensions/enum_localization_ext.dart';

class PaymentWayView extends StatefulWidget {
  const PaymentWayView({
    Key key,
    this.initialValue,
    this.onSelected,
    this.allowedWays = const [
      PaymentWay.cash,
      PaymentWay.charge,
    ],
  }) : super(key: key);

  final PaymentWay initialValue;
  final ValueChanged<PaymentWay> onSelected;
  final List<PaymentWay> allowedWays;

  @override
  _PaymentWayViewState createState() => _PaymentWayViewState();
}

class _PaymentWayViewState extends State<PaymentWayView> {
  PaymentWay _value;

  @override
  Widget build(BuildContext context) {
    _value ??= widget.initialValue;
    return Wrap(
      spacing: 8,
      children: PaymentWay.values.map(((PaymentWay paymentWay) {
        return ChoiceChip(
          pressElevation: 0,
          label: Text(paymentWay.localized),
          selected: _value == paymentWay,
          onSelected: widget.allowedWays.contains(paymentWay)
              ? (bool selected) {
                  setState(() {
                    _value = paymentWay;
                  });
                  widget.onSelected(paymentWay);
                }
              : null,
        );
      })).toList(growable: false),
    );
  }
}
