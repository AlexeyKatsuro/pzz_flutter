import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pzz/models/basket_product.dart';
import 'package:pzz/models/combined_basket_product.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/ui/widgets/counter.dart';
import 'package:pzz/utils/extensions/enum_localization_ext.dart';

class BasketCombinedItem extends StatelessWidget {
  const BasketCombinedItem({
    required this.combinedProduct,
    required this.onAddClick,
    required this.onRemoveClick,
  });

  final CombinedBasketProduct combinedProduct;
  final Function(BasketProduct) onAddClick;
  final Function(BasketProduct) onRemoveClick;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          combinedProduct.title,
          style: theme.textTheme.headline6!.copyWith(
            color: theme.primaryColor,
          ),
        ),
        for (ProductSize? size in combinedProduct.availableSizes) ...[
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Counter(
                count: combinedProduct.countOfProductsBy(size),
                onRemoveClick: () {
                  onRemoveClick(combinedProduct.productsBy(size));
                },
                onAddClick: () {
                  onAddClick(combinedProduct.productsBy(size));
                },
              ),
              if (size != null)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                  ),
                  child: Text(
                    size.localized(localizations!),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              Expanded(
                child: Text(
                  '${(combinedProduct.priceOfProductsBy(size)).toStringAsFixed(2)} р.',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            ],
          )
        ]
      ],
    );
  }
}
