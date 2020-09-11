import 'package:flutter/material.dart';
import 'package:pzz/models/basket_product.dart';
import 'package:pzz/models/combined_basket_product.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/ui/widgets/counter.dart';
import 'package:pzz/utils/extensions/enum_localization_ext.dart';

class BasketCombinedItem extends StatelessWidget {
  final CombinedBasketProduct combinedProduct;
  final Function(BasketProduct) onAddClick;
  final Function(BasketProduct) onRemoveClick;

  BasketCombinedItem({
    @required this.combinedProduct,
    @required this.onAddClick,
    @required this.onRemoveClick,
  }) : assert(combinedProduct != null);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          combinedProduct.title,
          style: theme.textTheme.headline6.copyWith(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        for (ProductSize size in combinedProduct.availableSizes) ...[
          SizedBox(
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
                    size.localizedString,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              Expanded(
                child: Text(
                  '${(combinedProduct.priceOfProductsBy(size)).toStringAsFixed(2)} р.',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      ),
                ),
              )
            ],
          )
        ]
      ],
    );
  }
}
