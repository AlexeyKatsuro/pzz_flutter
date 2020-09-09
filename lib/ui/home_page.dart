import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/routes.dart';
import 'package:pzz/ui/widgets/badge_counter.dart';
import 'package:pzz/ui/widgets/pizza.dart';
import 'package:redux/redux.dart';
import 'package:pzz/utils/extensions/to_product_ext.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onInit;

  HomePage({@required this.onInit}) : assert(onInit != null);

  @override
  _HomePageState createState() => _HomePageState();
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
      converter: _ViewModel.formStore,
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(StringRes.appName),
          ),
          body: vm.loading ? _buildLoader() : _buildPizzasList(vm),
          floatingActionButton: vm.isBasketButtonVisible ? _buildBasketButton(vm.basketCount) : null,
        );
      },
    );
  }

  Widget _buildPizzasList(_ViewModel vm) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemBuilder: (context, index) => PizzaWidget(
              basketCountMap: vm.getBasketCountMap(vm.pizzas[index]),
              pizza: vm.pizzas[index],
              onRemovePizzaClick: vm.onRemovePizzaClick,
              onAddPizzaClick: vm.onAddPizzaClick,
            ),
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
  final void Function(Pizza, ProductSize) onAddPizzaClick;
  final void Function(Pizza, ProductSize) onRemovePizzaClick;
  final Map<ProductSize, int> Function(Pizza) getBasketCountMap;

  bool get isBasketButtonVisible => basketCount != 0;

  _ViewModel({
    @required this.pizzas,
    @required this.loading,
    @required this.onAddPizzaClick,
    @required this.onRemovePizzaClick,
    @required this.getBasketCountMap,
    @required this.basketCount,
  })  : assert(pizzas != null),
        assert(loading != null),
        assert(getBasketCountMap != null),
        assert(basketCount != null),
        assert(onAddPizzaClick != null);

  static _ViewModel formStore(Store<AppState> store) {
    return _ViewModel(
      pizzas: pizzasSelector(store.state),
      loading: store.state.isLoading,
      basketCount: basketCountSelector(store.state),
      getBasketCountMap: (pizza) {
        return {}; //basketCountMap(store, pizza);
      },
      onAddPizzaClick: (pizza, size) => store.dispatch(
        AddProductAction(pizza.toProduct(size)),
      ),
      onRemovePizzaClick: (pizza, size) => store.dispatch(
        RemoveProductAction(pizza.toProduct(size)),
      ),
    );
  }
}
