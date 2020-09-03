import 'package:collection/collection.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/dto/basket_item_dto.dart';
import 'package:pzz/models/pizza.dart';
import 'package:redux/redux.dart';

int basketCountSelector(Store<AppState> store) {
  return store.state.basket?.items?.length ?? 0;
}

Map<PizzaSize, int> basketCountMap(Store<AppState> store, Pizza pizza) {
  final List<BasketItemDto> pizzasItems =
      store.state.basket?.items?.where((element) => element.id == pizza.id)?.toList() ?? [];

  Map<PizzaSize, List<BasketItemDto>> sizeItemsMap =
      groupBy(pizzasItems, (BasketItemDto e) => PizzaSizeExt.fromString(e.size));

  return sizeItemsMap.map((key, value) => MapEntry(key, value.length));
}
