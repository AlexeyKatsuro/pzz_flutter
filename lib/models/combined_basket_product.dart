import 'package:flutter/cupertino.dart';
import 'package:pzz/models/basket_product.dart';
import 'package:pzz/models/pizza.dart';

@immutable
class CombinedBasketProduct {
  const CombinedBasketProduct({
    @required this.id,
    @required this.title,
    @required this.type,
    @required this.products,
  })  : assert(id != null),
        assert(title != null),
        assert(type != null),
        assert(products != null);

  final int id;
  final String title;
  final ProductType type;
  final List<BasketProduct> products;

  int get productsCount => products.length;

  num get price => products.fold(0, (sum, element) => sum + element.price);

  bool hasSize(ProductSize size) => products.any((element) => element.size == size);

  int countOfProductsBy(ProductSize size) => products.fold(0, (count, element) {
        if (element.size == size) {
          return count + 1;
        } else {
          return count;
        }
      });

  num priceOfProductsBy(ProductSize size) => products.fold(0.0, (sum, element) {
        if (element.size == size) {
          return sum + element.price;
        } else {
          return sum;
        }
      });

  BasketProduct productsBy(ProductSize size) => products.firstWhere((element) => element.size == size);

  Set<ProductSize> get availableSizes => products.map((e) => e.size).toSet();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CombinedBasketProduct &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          products == other.products;

  @override
  int get hashCode => id.hashCode ^ type.hashCode ^ products.hashCode;
}

extension ListCombinedBasketProductExt on List<CombinedBasketProduct> {
  int get allProductsCount => this.fold(0, (previousValue, element) => previousValue + element.productsCount);
}
