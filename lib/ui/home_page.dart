import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/actions/navigate_to_action.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/combined_basket_product.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/res/constants.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/routes.dart';
import 'package:pzz/ui/widgets/badge_counter.dart';
import 'package:pzz/ui/widgets/counter.dart';
import 'package:pzz/ui/widgets/error_view.dart';
import 'package:pzz/ui/widgets/pizza.dart';
import 'package:pzz/utils/extensions/to_product_ext.dart';
import 'package:pzz/utils/scoped.dart';
import 'package:pzz/utils/widgets/error_scoped_notifier.dart';
import 'package:pzz/utils/widgets/slivers/sliver_child_builder_separated_delegate.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget implements Scoped {
  @override
  String get scope => Routes.homeScreen;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) => store.dispatch(InitialAction(scope: Routes.homeScreen)),
      converter: (store) => _ViewModel.formStore(store, widget.scope),
      builder: (context, vm) {
        return Scaffold(
          body: ErrorScopedNotifier(
            widget.scope,
            child: AnimatedSwitcher(
              duration: kDurationFast,
              child: _buildContent(context, vm),
            ),
          ),
          floatingActionButton: _HomeFab(
            scrollController: scrollController,
            basketCount: vm.basketCount,
            showOnOffset: screenSize.height,
            onArrowClick: () {
              // scroll to top
              scrollController.animateTo(
                scrollController.initialScrollOffset,
                curve: Curves.easeInOutCirc,
                duration: kDurationMedium,
              );
            },
            onBasketClick: vm.onBasketClick,
          ),
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
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          title: const Text(StringRes.appName),
          floating: true,
          forceElevated: true,
          /*  actions: [
            IconButton(
              icon: Icon(Icons.person_outline),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.personalInfoScreen);
              },
            ),
          ],*/
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          sliver: SliverList(
            delegate: SliverChildBuilderSeparatedDelegate(
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemBuilder: (context, index) {
                final pizza = vm.pizzas[index];
                return PizzaWidget(
                  combinedProduct: vm.getCombinedProduct(pizza.type, pizza.id),
                  pizza: pizza,
                  onRemovePizzaClick: vm.onRemovePizzaClick,
                  onAddPizzaClick: vm.onAddPizzaClick,
                );
              },
              itemCount: vm.pizzas.length,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
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
  final VoidCallback onBasketClick;

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
    @required this.onBasketClick,
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
      onBasketClick: () => store.dispatch(NavigateAction.push(Routes.basketScreen)),
    );
  }
}

class _HomeFab extends StatefulWidget {
  const _HomeFab({
    Key key,
    @required this.basketCount,
    @required this.scrollController,
    @required this.showOnOffset,
    @required this.onArrowClick,
    @required this.onBasketClick,
  }) : super(key: key);
  final int basketCount;
  final double showOnOffset;
  final ScrollController scrollController;
  final VoidCallback onArrowClick;
  final VoidCallback onBasketClick;

  @override
  __HomeFabState createState() => __HomeFabState();
}

class __HomeFabState extends State<_HomeFab> with TickerProviderStateMixin {
  bool _showUpButton = false;

  AnimationController _arrowController;
  Animation<double> _arrowAnimation;
  AnimationController _basketController;
  Animation<double> _basketAnimation;
  Animation<Size> _sizeAnimation;
  final double _fabSize = 56;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_checkOffset);
    _arrowController = AnimationController(duration: kDurationFast, vsync: this);
    _arrowAnimation = CurvedAnimation(parent: _arrowController, curve: Curves.easeIn);
    _basketController = AnimationController(duration: kDurationFast, vsync: this);
    _basketAnimation = CurvedAnimation(parent: _basketController, curve: Curves.easeIn);
    if (widget.basketCount > 0) {
      _basketController.forward();
    }
    _sizeAnimation = SizeTween(begin: Size(0, 0), end: Size(_fabSize, _fabSize)).animate(_basketAnimation);
  }

  @override
  void dispose() {
    super.dispose();
    _arrowController.dispose();
    _basketController.dispose();
  }

  void _checkOffset() {
    if (!_showUpButton && widget.scrollController.offset > widget.showOnOffset) {
      _showUpButton = true;
      _arrowController.forward();
    }

    if (_showUpButton && widget.scrollController.offset <= widget.showOnOffset) {
      _arrowController.reverse();
      _showUpButton = false;
    }
  }

  @override
  void didUpdateWidget(covariant _HomeFab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.basketCount != widget.basketCount && oldWidget.basketCount == 0 || widget.basketCount == 0) {
      if (widget.basketCount > 0) {
        _basketController.forward();
      } else {
        _basketController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // fixed width need to center arrow button relative to fab (visible and invisible ) horizontally
        SizedBox(
          width: _fabSize,
          child: ScaleTransition(
            scale: _arrowAnimation,
            child: CircularButton(
              onPressed: widget.onArrowClick,
              style: ElevatedButton.styleFrom(
                primary: theme.colorScheme.primaryVariant,
                onPrimary: theme.colorScheme.onPrimary,
                elevation: 4,
              ),
              child: Icon(Icons.keyboard_arrow_up),
            ),
          ),
        ),
        // TODO: CRUTCH with animation of width form 0 to fixed fab width, to make the parent resize, that get an animation of the arrow shift when fab appears/disappears
        AnimatedBuilder(
          animation: _sizeAnimation,
          builder: (context, child) {
            return SizedBox.fromSize(
              child: child,
              size: _sizeAnimation.value,
            );
          },
          child: Center(
            child: RotationTransition(
              turns: _basketAnimation,
              child: ScaleTransition(
                scale: _basketAnimation,
                child: BadgeCounter(
                  count: widget.basketCount,
                  child: FloatingActionButton(
                    child: const Icon(Icons.shopping_cart),
                    onPressed: widget.onBasketClick,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
