import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/models/basket_product.dart';
import 'package:pzz/models/dto/basket_item_dto.dart';
import 'package:pzz/models/pizza.dart';

extension PizzaToPoductExt on Pizza {
  Product toProduct(ProductSize size) {
    return Product(id: this.id, type: ProductType.pizza, size: size);
  }
}

extension BasketItemToPoductExt on BasketItemDto {
  Product toProduct() {
    return Product(
      id: id,
      type: ProductTypeExt.fromStringOrNull(type),
      size: ProductSizeExt.fromStringOrNull(size),
    );
  }
}

extension BasketProductToPoductExt on BasketProduct {
  Product toProduct() {
    return Product(
      id: id,
      type: type,
      size: size,
    );
  }
}
