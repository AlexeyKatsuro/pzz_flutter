import 'package:flutter/material.dart';
import 'package:pzz/models/basket_address.dart';
import 'package:pzz/models/basket_product.dart';
import 'package:pzz/res/constants.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/utils/extensions/enum_localization_ext.dart';
import 'package:pzz/utils/extensions/widget_extension.dart';

class ConfirmPlaceOrderView extends StatefulWidget {
  ConfirmPlaceOrderView({
    @required this.address,
    @required this.products,
    @required this.totalPriceText,
    @required this.onConfirm,
    @required this.isLoading,
  });

  final bool isLoading;
  final String totalPriceText;
  final BasketAddress address;
  final List<BasketProduct> products;
  final VoidCallback onConfirm;

  @override
  _ConfirmPlaceOrderViewState createState() => _ConfirmPlaceOrderViewState();
}

class _ConfirmPlaceOrderViewState extends State<ConfirmPlaceOrderView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 32,
              height: 6,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          ...[
            for (final product in widget.products) _buildProductRow(context, product),
          ].divideChildren(divider: Divider()),
          SizedBox(
            height: 20,
          ),
          _buildPersonInfo(
            context: context,
            icon: Icons.phone,
            name: StringRes.to_confirm_phone,
            value: widget.address.phone,
          ),
          Divider(),
          _buildPersonInfo(
            context: context,
            icon: Icons.room_outlined,
            name: StringRes.to_confirm_address,
            value: widget.address.makeFullAddress,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                StringRes.to_confirm_total_price,
                style: theme.textTheme.subtitle1.copyWith(fontFamily: 'Malina'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.totalPriceText,
                  style: theme.textTheme.headline6.copyWith(fontFamily: 'Malina'),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          SizedBox(
            width: double.infinity,
            child: AbsorbPointer(
              absorbing: widget.isLoading,
              child: ElevatedButton(
                child: AnimatedSwitcher(
                  child: widget.isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.onPrimary),
                          ))
                      : const Text(StringRes.to_confirm_button),
                  duration: kDurationFast,
                ),
                onPressed: widget.onConfirm,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildPersonInfo({
    BuildContext context,
    IconData icon,
    String name,
    String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 12,
        ),
        SizedBox(width: 4),
        Text(name),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildProductRow(BuildContext context, BasketProduct product) {
    final theme = Theme.of(context);
    String title = product.title;
    if (product.size != null) {
      title += '(${product.size.localizedString})';
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            product.priceText,
            style: theme.textTheme.bodyText1,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
