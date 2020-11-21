import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/combined_basket_product.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/res/constants.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/routes.dart';
import 'package:pzz/ui/widgets/badge_counter.dart';
import 'package:pzz/ui/widgets/error_view.dart';
import 'package:pzz/ui/widgets/pizza.dart';
import 'package:pzz/utils/extensions/to_product_ext.dart';
import 'package:pzz/utils/scoped.dart';
import 'package:pzz/utils/widgets/error_scoped_notifier.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget implements Scoped {
  final VoidCallback onInit;

  HomePage({@required this.onInit}) : assert(onInit != null);

  @override
  _HomePageState createState() => _HomePageState();

  @override
  String get scope => Routes.homeScreen;
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.formStore(store, widget.scope),
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(StringRes.appName),
            // actions: [
            //   IconButton(
            //     icon: Icon(Icons.person_outline),
            //     onPressed: () {
            //       Navigator.of(context).pushNamed(Routes.personalInfoScreen);
            //     },
            //   ),
            // ],
          ),
          body: ErrorScopedNotifier(
            widget.scope,
            child: AnimatedSwitcher(
              duration: kDurationFast,
              child: _buildContent(context, vm),
            ),
          ),
          floatingActionButton: vm.isBasketButtonVisible ? _buildBasketButton(vm.basketCount) : null,
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, _ViewModel viewModel) {
    if (viewModel.loading) {
      return _buildLoader();
    } else if (viewModel.errorMessage == null) {
      return _buildPizzasList(viewModel);
    } else {
      return _buildError(viewModel);
    }
  }

  Widget _buildError(_ViewModel viewModel) {
    return ErrorView(
      errorMessage: viewModel.errorMessage,
      onRepeatClick: viewModel.onRepeat,
    );
  }

  Widget _buildPizzasList(_ViewModel vm) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemBuilder: (context, index) {
          final pizza = vm.pizzas[index];
          return PizzaWidget(
            combinedProduct: vm.getCombinedProduct(pizza.type, pizza.id),
            pizza: pizza,
            onRemovePizzaClick: vm.onRemovePizzaClick,
            onAddPizzaClick: vm.onAddPizzaClick,
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 8),
        itemCount: vm.pizzas.length);
  }

  Widget _buildLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildBasketButton(int basketCount) {
    return BadgeCounter(
        count: basketCount,
        child: FloatingActionButton(
          child: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.basketScreen);
          },
        ));
  }
}

class _ViewModel {
  final List<Pizza> pizzas;
  final bool loading;
  final int basketCount;
  final String errorMessage;
  final VoidCallback onRepeat;
  final void Function(Pizza, ProductSize) onAddPizzaClick;
  final void Function(Pizza, ProductSize) onRemovePizzaClick;
  final CombinedBasketProduct Function(ProductType type, int productId) getCombinedProduct;

  bool get isBasketButtonVisible => basketCount != 0;

  _ViewModel({
    @required this.pizzas,
    @required this.errorMessage,
    @required this.loading,
    @required this.onAddPizzaClick,
    @required this.onRemovePizzaClick,
    @required this.getCombinedProduct,
    @required this.onRepeat,
    @required this.basketCount,
  })  : assert(pizzas != null),
        assert(loading != null),
        assert(basketCount != null),
        assert(getCombinedProduct != null),
        assert(onAddPizzaClick != null);

  static _ViewModel formStore(Store<AppState> store, String scope) {
    return _ViewModel(
      errorMessage: homePageStateSelector(store.state).errorMessage,
      pizzas: pizzasSelector(store.state),
      loading: homePageStateSelector(store.state).isLoading,
      basketCount: basketCountSelector(store.state),
      // TODO wrong approach, UI doesn't should request data through ViewModel
      getCombinedProduct: (type, productId) => combinedProductSelectorBy(store.state, type, productId),
      onAddPizzaClick: (pizza, size) => store.dispatch(
        AddProductAction(scope: scope, product: pizza.toProduct(size)),
      ),
      onRemovePizzaClick: (pizza, size) => store.dispatch(
        RemoveProductAction(scope: scope, product: pizza.toProduct(size)),
      ),
      onRepeat: () => store.dispatch(InitialAction(scope: scope)),
    );
  }
}
