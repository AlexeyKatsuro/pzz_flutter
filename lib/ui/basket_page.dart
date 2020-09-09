import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/basket_product.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/ui/widgets/basket_item.dart';
import 'package:pzz/utils/extensions/enum_localization_ext.dart';
import 'package:pzz/utils/extensions/to_product_ext.dart';
import 'package:redux/redux.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) {
        return _ViewModel.formStore(store);
      },
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: Text(StringRes.basket),
          ),
          body: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemBuilder: (context, index) {
                final item = vm.items[index];
                final count = vm.items.where((element) => item.id == element.id && item.size == element.size).length;
                return BasketItem(
                  name: item.title,
                  price: item.price,
                  size: item.size?.localizedString,
                  count: count,
                  onAddClick: () {
                    vm.onAddItemClick(item);
                  },
                  onRemoveClick: () {
                    vm.onRemoveItemClick(item);
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: vm.items.length),
        );
      },
    );
  }
}

class _ViewModel {
  final List<BasketProduct> items;
  final bool loading;
  final int basketCount;
  final void Function(BasketProduct) onAddItemClick;
  final void Function(BasketProduct) onRemoveItemClick;

  // final Map<ProductSize, int> Function(Pizza) getBasketCountMap;

  bool get isBasketButtonVisible => basketCount != 0;

  _ViewModel({
    @required this.items,
    @required this.loading,
    @required this.onAddItemClick,
    @required this.onRemoveItemClick,
    @required this.basketCount,
  })  : assert(items != null),
        assert(loading != null),
        assert(basketCount != null),
        assert(onAddItemClick != null);

  static _ViewModel formStore(Store<AppState> store) {
    return _ViewModel(
      items: basketProductsSelector(store.state),
      loading: store.state.isLoading,
      basketCount: basketCountSelector(store.state),
      onAddItemClick: (item) {
        store.dispatch(AddProductAction(item.toProduct()));
      },
      onRemoveItemClick: (item) {
        store.dispatch(RemoveProductAction(item.toProduct()));
      },
    );
  }
}
