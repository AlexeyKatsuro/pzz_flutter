import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/combined_basket_product.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/ui/widgets/basket_combined_item.dart';
import 'package:pzz/ui/widgets/personal_info_form.dart';
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
      distinct: true,
      onWillChange: (previousViewModel, newViewModel) {
        if (newViewModel.isBasketEmpty) {
          Navigator.of(context).pop();
        }
      },
      converter: (store) {
        return _ViewModel.formStore(store);
      },
      builder: _build,
    );
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${StringRes.total}: ${vm.totalAmount.toStringAsFixed(2)} р.'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 12),
        children: [
          ..._buildProducts(context, vm, ProductType.pizza),
          ..._buildProducts(context, vm, ProductType.sauce),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: OutlinedButton(
              onPressed: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      StringRes.chooseFeeSauces(vm.freeSauceCounts),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
          /* for (int index = 0; index < vm.sauces.length; index++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SauceWidget(
                item: vm.sauces[index],
                onAddClick: () => vm.onAddItemClick(vm.sauces[index].toProduct()),
              ),
            ),*/
          DividedCenterTitle(StringRes.deliveryAddress),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: PersonalInfoFormContainer(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildProducts(BuildContext context, _ViewModel vm, ProductType type) {
    final items = vm.itemsMap[type] ?? [];
    return [
      DividedCenterTitle(type.localizedPluralsString),
      if (items.length != 0) const SizedBox(height: 12),
      for (int index = 0; index < items.length; index++)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              BasketCombinedItem(
                combinedProduct: items[index],
                onAddClick: (p) => vm.onAddItemClick(p.toProduct()),
                onRemoveClick: (p) => vm.onRemoveItemClick(p.toProduct()),
              ),
              if (index != items.length - 1) Divider(),
            ],
          ),
        ),
    ];
  }
}

class DividedCenterTitle extends StatelessWidget {
  const DividedCenterTitle(
    this.title, {
    Key key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black54),
          ),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}

class _ViewModel {
  final int basketCount;
  final void Function(Product) onAddItemClick;
  final void Function(Product) onRemoveItemClick;
  final Map<ProductType, List<CombinedBasketProduct>> itemsMap;
  final List<Sauce> sauces;

  final Basket basket;

  final int freeSauceCounts;

  bool get isBasketEmpty => basketCount == 0;

  num get totalAmount => basket.totalAmount;

  _ViewModel({
    @required this.itemsMap,
    @required this.sauces,
    @required this.basket,
    @required this.onAddItemClick,
    @required this.onRemoveItemClick,
    @required this.basketCount,
    @required this.freeSauceCounts,
  })  : assert(itemsMap != null),
        assert(basketCount != null),
        assert(sauces != null),
        assert(onAddItemClick != null);

  static _ViewModel formStore(Store<AppState> store) {
    return _ViewModel(
      basket: basketSelector(store.state),
      sauces: saucesSelector(store.state),
      itemsMap: combinedBasketProductsTypedMap(store.state),
      basketCount: basketCountSelector(store.state),
      freeSauceCounts: freeSauceCountsSelector(store.state),
      onAddItemClick: (item) {
        store.dispatch(AddProductAction(item));
      },
      onRemoveItemClick: (item) {
        store.dispatch(RemoveProductAction(item));
      },
    );
  }
}
