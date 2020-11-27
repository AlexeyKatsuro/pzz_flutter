import 'package:flutter/material.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/pizza_variant.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/ui/widgets/counter.dart';
import 'package:pzz/utils/extensions/enum_localization_ext.dart';

class PizzaVariantWidget extends StatelessWidget {
  final PizzaVariant variant;
  final int countInBasket;
  final void Function(ProductSize) onAddPizzaClick;
  final void Function(ProductSize) onRemovePizzaClick;

  const PizzaVariantWidget({
    @required this.countInBasket,
    @required this.variant,
    @required this.onAddPizzaClick,
    @required this.onRemovePizzaClick,
  })  : assert(variant != null),
        assert(onRemovePizzaClick != null),
        assert(countInBasket != null),
        assert(onAddPizzaClick != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                variant.size.localizedString,
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
          child: countInBasket > 0 ? _buildCounter() : _buildToBasketButton(context),
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

  Widget _buildToBasketButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onAddPizzaClick(variant.size);
      },
      child: Text(StringRes.in_basket),
    );
  }
}
