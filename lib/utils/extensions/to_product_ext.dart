import 'package:pzz/models/basket_product.dart';
import 'package:pzz/models/dto/basket_item_dto.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/models/sauce.dart';

extension PizzaToPoductExt on Pizza {
  Product toProduct(ProductSize size) {
    final num price = variants.firstWhere((element) => element.size == size).price;
    return Product(
      id: id,
      title: name,
      type: type,
      size: size,
      price: price,
    );
  }
}

extension BasketItemToPoductExt on BasketItemDto {
  Product toProduct() {
    return Product(
      id: id!,
      title: title!,
      type: ProductTypeExt.fromStringOrNull(type)!,
      size: ProductSizeExt.fromStringOrNull(size),
      price: price!,
    );
  }
}

extension BasketProductToPoductExt on BasketProduct {
  Product toProduct() {
    return Product(
      id: id,
      title: title,
      type: type,
      size: size,
      price: price,
    );
  }
}

extension SauceItemToPoductExt on Sauce {
  Product toProduct() {
    return Product(
      id: id,
      title: title,
      type: type,
      size: ProductSize.big,
      price: price,
    );
  }
}
