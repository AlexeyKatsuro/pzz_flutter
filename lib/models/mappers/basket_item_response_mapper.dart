import 'package:pzz/models/basket_product.dart';
import 'package:pzz/models/dto/basket_item_dto.dart';
import 'package:pzz/models/pizza.dart';

class BasketItemResponseMapper {
  static BasketProduct map(BasketItemDto from) {
    return BasketProduct(
      id: from.id,
      price: (from.price ?? 0) / 10000,
      title: from.title,
      type: ProductTypeExt.fromStringOrNull(from.type),
      size: ProductSizeExt.fromStringOrNull(from.size),
    );
  }
}
