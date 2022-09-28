import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/actions/navigation_actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/combined_basket_product.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/routes.dart';
import 'package:pzz/ui/containers/payment_way_container.dart';
import 'package:pzz/ui/widgets/basket_combined_item.dart';
import 'package:pzz/ui/widgets/personal_info_form.dart';
import 'package:pzz/utils/extensions/enum_localization_ext.dart';
import 'package:pzz/utils/extensions/to_product_ext.dart';
import 'package:pzz/utils/scoped.dart';
import 'package:pzz/utils/widgets/error_scoped_notifier.dart';
import 'package:pzz/utils/widgets/loading_switcher.dart';
import 'package:redux/redux.dart';

class BasketPage extends StatefulWidget implements Scoped {
  @override
  final String scope = Routes.basketScreen;

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (store) {
        return _ViewModel.formStore(store, widget.scope);
      },
      builder: _build,
    );
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.totalPrice('${vm.totalAmount.toStringAsFixed(2)} р.'),
        ),
      ),
      body: ErrorScopedNotifier(
        widget.scope,
        child: ListView(
          children: [
            const SizedBox(
              height: 12,
            ),
            ..._buildProducts(localizations, vm, ProductType.pizza),
            ..._buildProducts(localizations, vm, ProductType.sauce),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: OutlinedButton(
                onPressed: vm.onChooseSauceClick,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        vm.freeSauceCounts != 0
                            ? localizations.chooseFeeSauces(vm.freeSauceCounts)
                            : localizations.addSauces,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
            DividedCenterTitle(localizations.deliveryAddress),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: PersonalInfoFormContainer(),
            ),
            DividedCenterTitle(localizations.payment_way),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PaymentWayContainer(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: AbsorbPointer(
                absorbing: vm.isLoading,
                child: ElevatedButton(
                  onPressed: vm.onPlaceOrderClick,
                  child: LoadingSwitcher(
                    isLoading: vm.isLoading,
                    child: Text(localizations.placeOrder),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildProducts(
    AppLocalizations localizations,
    _ViewModel vm,
    ProductType type,
  ) {
    final items = vm.itemsMap[type] ?? [];
    return [
      DividedCenterTitle(type.localizedPlurals(localizations)),
      if (items.isNotEmpty) const SizedBox(height: 12),
      for (int index = 0; index < items.length; index++)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              BasketCombinedItem(
                combinedProduct: items[index],
                onAddClick: (p) => vm.onAddItemClick(p.toProduct()),
                onRemoveClick: (p) => vm.onRemoveItemClick(p.toProduct()),
              ),
              if (index != items.length - 1) const Divider(),
            ],
          ),
        ),
    ];
  }
}

class DividedCenterTitle extends StatelessWidget {
  const DividedCenterTitle(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: theme.textTheme.headline6,
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class _ViewModel {
  _ViewModel({
    required this.basketCount,
    required this.itemsMap,
    required this.basket,
    required this.freeSauceCounts,
    required this.isLoading,
    required this.onAddItemClick,
    required this.onRemoveItemClick,
    required this.onPlaceOrderClick,
    required this.onChooseSauceClick,
  });

  factory _ViewModel.formStore(Store<AppState> store, String scope) {
    return _ViewModel(
      isLoading: isConfirmLoadingSelector(store.state),
      basket: basketSelector(store.state),
      itemsMap: combinedBasketProductsTypedMap(store.state),
      basketCount: basketCountSelector(store.state),
      freeSauceCounts: freeSauceCountsSelector(store.state),
      onChooseSauceClick: () =>
          store.dispatch(NavigateAction.push(Routes.saucesScreen)),
      onAddItemClick: (item) =>
          store.dispatch(AddProductAction(product: item, scope: scope)),
      onRemoveItemClick: (item) =>
          store.dispatch(RemoveProductAction(product: item, scope: scope)),
      onPlaceOrderClick: () =>
          store.dispatch(TryPlaceOrderAction(scope: scope)),
    );
  }

  final int basketCount;
  final Map<ProductType, List<CombinedBasketProduct>> itemsMap;
  final Basket basket;
  final int freeSauceCounts;
  final bool isLoading;

  // Callbacks
  final ValueSetter<Product> onAddItemClick;
  final ValueSetter<Product> onRemoveItemClick;
  final VoidCallback onPlaceOrderClick;
  final VoidCallback onChooseSauceClick;

  bool get isBasketEmpty => basketCount == 0;

  num get totalAmount => basket.totalAmount;
}
