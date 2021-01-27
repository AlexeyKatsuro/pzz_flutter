import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pzz/models/combined_basket_product.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/res/constants.dart';
import 'package:pzz/ui/widgets/pizza_variant.dart';
import 'package:pzz/utils/extensions/widget_extension.dart';

class PizzaWidget extends StatelessWidget {
  const PizzaWidget({
    required this.pizza,
    required this.combinedProduct,
    required this.onAddPizzaClick,
    required this.onRemovePizzaClick,
  });

  final Pizza pizza;
  final CombinedBasketProduct? combinedProduct; // nullable
  final void Function(Pizza, ProductSize) onAddPizzaClick;
  final void Function(Pizza, ProductSize) onRemovePizzaClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
            fadeInDuration: kDurationFast,
            imageUrl: pizza.photo,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
            errorWidget: (context, url, error) => const Icon(Icons.error_outline),
          ),
          const Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  pizza.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5!.copyWith(color: Theme.of(context).primaryColor),
                ),
                ...[
                  for (final variant in pizza.variants)
                    PizzaVariantWidget(
                      countInBasket: combinedProduct?.countOfProductsBy(variant.size) ?? 0,
                      onRemovePizzaClick: (size) {
                        onRemovePizzaClick(pizza, size);
                      },
                      variant: variant,
                      onAddPizzaClick: (size) {
                        onAddPizzaClick(pizza, size);
                      },
                    ),
                ].divideChildren(divider: const Divider(height: 12)),
                Text(
                  pizza.description,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
