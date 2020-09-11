import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/combined_basket_product.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/ui/widgets/basket_combined_item.dart';
import 'package:pzz/ui/widgets/sauce.dart';
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
            title: Text('${StringRes.total}: ${vm.totalAmount.toStringAsFixed(2)} р.'),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(vertical: 12),
            children: [
              for (int index = 0; index < vm.items.length; index++)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      BasketCombinedItem(
                        combinedProduct: vm.items[index],
                        onAddClick: (p) => vm.onAddItemClick(p.toProduct()),
                        onRemoveClick: (p) => vm.onRemoveItemClick(p.toProduct()),
                      ),
                      if (index != vm.items.length - 1) Divider(),
                    ],
                  ),
                ),
              Container(
                height: 240,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: vm.sauces.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final item = vm.sauces[index];
                    return SauceWidget(
                      item: item,
                      onAddClick: () => vm.onAddItemClick(item.toProduct()),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final int basketCount;
  final void Function(Product) onAddItemClick;
  final void Function(Product) onRemoveItemClick;
  final List<CombinedBasketProduct> items;
  final List<Sauce> sauces;

  final Basket basket;

  bool get isBasketEmpty => basketCount == 0;

  num get totalAmount => basket.totalAmount;

  _ViewModel({
    @required this.items,
    @required this.sauces,
    @required this.basket,
    @required this.onAddItemClick,
    @required this.onRemoveItemClick,
    @required this.basketCount,
  })  : assert(items != null),
        assert(basketCount != null),
        assert(sauces != null),
        assert(onAddItemClick != null);

  static _ViewModel formStore(Store<AppState> store) {
    return _ViewModel(
      basket: basketSelector(store.state),
      sauces: saucesSelector(store.state),
      items: combinedBasketProducts(store.state),
      basketCount: basketCountSelector(store.state),
      onAddItemClick: (item) {
        store.dispatch(AddProductAction(item));
      },
      onRemoveItemClick: (item) {
        store.dispatch(RemoveProductAction(item));
      },
    );
  }
}
