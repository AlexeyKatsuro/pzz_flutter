import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/basket_address.dart';
import 'package:pzz/models/basket_product.dart';
import 'package:pzz/routes.dart';
import 'package:pzz/ui/widgets/confirm_place_order_view.dart';
import 'package:pzz/utils/scoped.dart';
import 'package:redux/redux.dart';

class ConfirmPlaceOrderDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConfirmPlaceOrderContainer(),
    );
  }
}

class ConfirmPlaceOrderContainer extends StatelessWidget implements Scoped {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.fromStore(store, scope),
      builder: (_, _ViewModel viewModel) {
        return _build(context, viewModel);
      },
    );
  }

  Widget _build(BuildContext context, _ViewModel viewModel) {
    return ConfirmPlaceOrderView(
      isLoading: viewModel.isLoading,
      totalPriceText: viewModel.totalPriceText,
      address: viewModel.address,
      products: viewModel.products,
      onConfirm: viewModel.onConfirm,
    );
  }

  @override
  String get scope => Routes.confirmPlaceOrderDialog;
}

class _ViewModel {
  _ViewModel({
    required this.isLoading,
    required this.totalPriceText,
    required this.address,
    required this.products,
    required this.onConfirm,
  });

  factory _ViewModel.fromStore(Store<AppState> store, String scope) {
    return _ViewModel(
      totalPriceText: store.state.basket.totalAmountText,
      address: store.state.basket.address,
      products: store.state.basket.items,
      isLoading: isConfirmLoadingSelector(store.state),
      onConfirm: () {
        store.dispatch(ConfirmPlaceOrderAction(scope: scope));
      },
    );
  }

  final bool isLoading;
  final String totalPriceText;
  final BasketAddressEntity address;
  final List<BasketProduct> products;
  final VoidCallback onConfirm;
}
