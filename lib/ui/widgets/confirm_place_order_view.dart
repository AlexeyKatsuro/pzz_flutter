import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pzz/models/basket_address.dart';
import 'package:pzz/models/basket_product.dart';
import 'package:pzz/ui/widgets/bottom_sheet_drag_bar.dart';
import 'package:pzz/utils/extensions/enum_localization_ext.dart';
import 'package:pzz/utils/extensions/widget_extension.dart';
import 'package:pzz/utils/widgets/loading_switcher.dart';

class ConfirmPlaceOrderView extends StatefulWidget {
  const ConfirmPlaceOrderView({
    required this.address,
    required this.products,
    required this.totalPriceText,
    required this.onConfirm,
    required this.isLoading,
  });

  final bool isLoading;
  final String totalPriceText;
  final BasketAddressEntity address;
  final List<BasketProduct> products;
  final VoidCallback onConfirm;

  @override
  _ConfirmPlaceOrderViewState createState() => _ConfirmPlaceOrderViewState();
}

class _ConfirmPlaceOrderViewState extends State<ConfirmPlaceOrderView> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const BottomSheetDragBar(),
          ...[
            for (final product in widget.products) _buildProductRow(theme, localizations, product),
          ].divideChildren(divider: const Divider()),
          const SizedBox(
            height: 20,
          ),
          _buildPersonInfo(
            context: context,
            icon: Icons.phone,
            name: localizations.toConfirmPhone,
            value: widget.address.phone,
          ),
          const Divider(),
          _buildPersonInfo(
            context: context,
            icon: Icons.room_outlined,
            name: localizations.toConfirmAddress,
            value: widget.address.makeFullAddress(localizations),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                localizations.toConfirmTotalPrice,
                style: theme.textTheme.subtitle1!.copyWith(fontFamily: 'Malina'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.totalPriceText,
                  style: theme.textTheme.headline6!.copyWith(fontFamily: 'Malina'),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          AbsorbPointer(
            absorbing: widget.isLoading,
            child: ElevatedButton(
              onPressed: widget.onConfirm,
              child: LoadingSwitcher(
                isLoading: widget.isLoading,
                child: Text(localizations.toConfirmButton),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildPersonInfo({
    required BuildContext context,
    IconData? icon,
    required String name,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 12,
        ),
        const SizedBox(width: 4),
        Text(name),
        const SizedBox(width: 12),
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

  Widget _buildProductRow(ThemeData theme, AppLocalizations localizations, BasketProduct product) {
    String title = product.title;
    if (product.size != null) {
      title += '(${product.size!.localized(localizations)})';
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(width: 12),
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
