import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/models/basket_product.dart';
import 'package:pzz/models/dto/basket_item_dto.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';

extension PizzaToPoductExt on Pizza {
  Product toProduct(ProductSize size) {
    final num price = variants.firstWhere((element) => element.size == size).price;
    return Product(id: this.id, type: ProductType.pizza, size: size, price: price);
  }
}

extension BasketItemToPoductExt on BasketItemDto {
  Product toProduct() {
    return Product(
      id: id,
      type: ProductTypeExt.fromStringOrNull(type),
      size: ProductSizeExt.fromStringOrNull(size),
      price: price,
    );
  }
}

extension BasketProductToPoductExt on BasketProduct {
  Product toProduct() {
    return Product(
      id: id,
      type: type,
      size: size,
      price: price,
    );
  }
}
