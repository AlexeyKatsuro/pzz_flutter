import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/basket_product.dart';
import 'package:pzz/models/combined_basket_product.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/ui/widgets/basket_combined_item.dart';
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
      onWillChange: (previousViewModel, newViewModel) {
        if (newViewModel.isBasketEmpty) {
          Navigator.of(context).pop();
        }
      },
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
                return BasketCombinedItem(
                  combinedProduct: item,
                  onAddClick: vm.onAddItemClick,
                  onRemoveClick: vm.onRemoveItemClick,
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
  final int basketCount;
  final void Function(BasketProduct) onAddItemClick;
  final void Function(BasketProduct) onRemoveItemClick;
  final List<CombinedBasketProduct> items;

  bool get isBasketEmpty => basketCount == 0;

  _ViewModel({
    @required this.items,
    @required this.onAddItemClick,
    @required this.onRemoveItemClick,
    @required this.basketCount,
  })  : assert(items != null),
        assert(basketCount != null),
        assert(onAddItemClick != null);

  static _ViewModel formStore(Store<AppState> store) {
    return _ViewModel(
      items: combinedBasketProducts(store.state),
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
