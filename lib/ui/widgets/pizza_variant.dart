import 'package:flutter/material.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/pizza_variant.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/utils/extensions/enum_localization_ext.dart';

class PizzaVariantWidget extends StatelessWidget {
  final PizzaVariant variant;
  final void Function(PizzaSize) onAddPizzaClick;

  const PizzaVariantWidget({
    @required this.variant,
    @required this.onAddPizzaClick,
  })  : assert(variant != null),
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
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
              ),
              Text(
                '${variant.weight} ${variant.diameter}',
              ),
            ],
          ),
        ),
        Expanded(
          child: OutlineButton(
            textColor: Theme.of(context).colorScheme.primary,
            onPressed: () {
              onAddPizzaClick(variant.size);
            },
            child: Text(StringRes.in_basket),
          ),
        )
      ],
    );
  }
}
