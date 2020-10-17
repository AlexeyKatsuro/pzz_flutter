import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/person_info_form/actions/person_info_form_actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/payment_way.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/ui/widgets/payment_way.dart';
import 'package:redux/redux.dart';
import 'package:pzz/utils/extensions/text_form_field_ext.dart';

class PaymentWayContainer extends StatefulWidget {
  @override
  _PaymentWayContainerState createState() => _PaymentWayContainerState();
}

class _PaymentWayContainerState extends State<PaymentWayContainer> {
  final TextEditingController textRentingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (_, _ViewModel viewModel) {
        return _build(context, viewModel);
      },
    );
  }

  Widget _build(BuildContext context, _ViewModel viewModel) {
    textRentingController.setTextIfNew(viewModel.renting);

    return Column(
      children: [
        PaymentWayView(
          initialValue: viewModel.paymentWay,
          onSelected: viewModel.onPaymentWayChanged,
        ),
        if (viewModel.isCash)
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: TextFormField(
              controller: textRentingController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                helperText: StringRes.prepare_to_charge,
                suffixText: 'руб.',
              ),
              onChanged: viewModel.onRentingChanged,
            ),
          )
      ],
    );
  }
}

class _ViewModel {
  final PaymentWay paymentWay;
  final String renting;
  final ValueChanged<PaymentWay> onPaymentWayChanged;
  final ValueChanged<String> onRentingChanged;

  _ViewModel({
    @required this.paymentWay,
    @required this.renting,
    @required this.onPaymentWayChanged,
    @required this.onRentingChanged,
  });

  bool get isCash => paymentWay == PaymentWay.cash;

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      paymentWay: paymentWaySelector(store.state),
      renting: rentingSelector(store.state),
      onPaymentWayChanged: (paymentWay) => store.dispatch(PaymentWayChangedAction(paymentWay)),
      onRentingChanged: (renting) => store.dispatch(RentingChangedAction(renting)),
    );
  }
}
