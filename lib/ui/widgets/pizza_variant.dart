import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/pizza_variant.dart';
import 'package:pzz/ui/widgets/counter.dart';
import 'package:pzz/utils/extensions/enum_localization_ext.dart';

class PizzaVariantWidget extends StatelessWidget {
  const PizzaVariantWidget({
    required this.countInBasket,
    required this.variant,
    required this.onAddPizzaClick,
    required this.onRemovePizzaClick,
  });

  final PizzaVariant variant;
  final int countInBasket;
  final void Function(ProductSize) onAddPizzaClick;
  final void Function(ProductSize) onRemovePizzaClick;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                variant.size.localized(localizations),
              ),
              Text(
                '${variant.price.toStringAsFixed(2)} р.',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                '${variant.weight} ${variant.diameter}',
              ),
            ],
          ),
        ),
        Expanded(
          child: countInBasket > 0 ? _buildCounter() : _buildToBasketButton(localizations),
        )
      ],
    );
  }

  Widget _buildCounter() {
    return Counter(
        onRemoveClick: () {
          onRemovePizzaClick(variant.size);
        },
        count: countInBasket,
        onAddClick: () {
          onAddPizzaClick(variant.size);
        });
  }

  Widget _buildToBasketButton(AppLocalizations localizations) {
    return OutlinedButton(
      onPressed: () {
        onAddPizzaClick(variant.size);
      },
      child: Text(localizations.inBasket),
    );
  }
}
