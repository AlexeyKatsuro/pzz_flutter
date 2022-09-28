import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:pzz/models/combined_basket_product.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/res/constants.dart';
import 'package:pzz/routes.dart';
import 'package:pzz/stores/basket_store.dart';
import 'package:pzz/stores/home_store.dart';
import 'package:pzz/ui/widgets/badge_counter.dart';
import 'package:pzz/ui/widgets/counter.dart';
import 'package:pzz/ui/widgets/error_view.dart';
import 'package:pzz/ui/widgets/pizza.dart';
import 'package:pzz/utils/scoped.dart';
import 'package:pzz/utils/ui_message.dart';
import 'package:pzz/utils/widgets/error_scoped_notifier.dart';
import 'package:pzz/utils/widgets/slivers/sliver_child_builder_separated_delegate.dart';

part 'home_page.g.dart';

class HomePage extends StatefulWidget implements Scoped {
  @override
  String get scope => Routes.homeScreen;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController scrollController;

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
    final homeStore = Provider.of<HomeStore>(context);
    final basketStore = Provider.of<BasketStore>(context);
    final localizations = AppLocalizations.of(context);
    final vm = _ViewModel(homeStore, basketStore);
    return Scaffold(
      body: ErrorScopedNotifier(
        widget.scope,
        child: AnimatedSwitcher(
          duration: kDurationFast,
          child: Observer(builder: (context) {
            return _buildContent(localizations, vm);
          },),
        ),
      ),
      floatingActionButton: Observer(builder: (context) {
        return _HomeFab(
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
        );
      },),
    );
  }

  Widget _buildContent(AppLocalizations? localizations, _ViewModel viewModel) {
    if (viewModel.loading) {
      return _buildLoader();
    } else if (viewModel.errorMessage == null) {
      return _buildPizzasList(viewModel);
    } else {
      return _buildError(localizations!, viewModel);
    }
  }

  Widget _buildError(AppLocalizations localizations, _ViewModel viewModel) {
    return ErrorView(
      errorMessage: viewModel.errorMessage!.localize(localizations),
      onRepeatClick: viewModel.onRepeat,
    );
  }

  Widget _buildPizzasList(_ViewModel vm) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          title: Text(AppLocalizations.of(context)!.appName),
          floating: true,
          forceElevated: true,
/*          actions: [
            IconButton(
              icon: Icon(Icons.person_outline),
              onPressed: () {
                StoreProvider.of<AppState>(context).dispatch(NavigateAction.push(Routes.successOrderPlacedDialog));
              },
            ),
          ],*/
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          sliver: Observer(builder: (context) {
            return SliverList(
              delegate: SliverChildBuilderSeparatedDelegate(
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return Observer(
                    builder: (context) {
                      final pizza = vm.pizzas[index];
                      return PizzaWidget(
                        combinedProduct:
                            pizza.value, // vm.getCombinedProduct(pizza.type, pizza.id),
                        pizza: pizza.key,
                        onRemovePizzaClick: vm.onRemovePizzaClick,
                        onAddPizzaClick: vm.onAddPizzaClick,
                      );
                    },
                  );
                },
                itemCount: vm.pizzasCount,
              ),
            );
          },),
        )
      ],
    );
  }

  Widget _buildLoader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ViewModel = _ViewModelBase with _$_ViewModel;

abstract class _ViewModelBase with Store {
  _ViewModelBase(this.homeStore, this.basketStore);

  final HomeStore homeStore;
  final BasketStore basketStore;

  @computed
  List<MapEntry<Pizza, CombinedBasketProduct?>> get pizzas {
    return [
      for (final pizza in homeStore.pizzas)
        MapEntry(
            pizza,
            basketStore.combinedProductBy[ProductType.pizza]
                ?.firstWhereOrNull((product) => product.id == pizza.id),),
    ];
  }

  @computed
  bool get loading => homeStore.isLoading;

  @computed
  int get basketCount => basketStore.basket.items.length;

  @computed
  UiMessage? get errorMessage => homeStore.errorMessage;

  @computed
  bool get isBasketButtonVisible => basketCount != 0;

  @computed
  int get pizzasCount => pizzas.length;

  void onRepeat() => homeStore.onRepeat();

  void onAddPizzaClick(Pizza pizza, ProductSize size) => basketStore.onAddPizzaClick(pizza, size);

  void onRemovePizzaClick(Pizza pizza, ProductSize size) =>
      basketStore.onRemovePizzaClick(pizza, size);

  void onBasketClick() => homeStore.onBasketClick();
}

class _HomeFab extends StatefulWidget {
  const _HomeFab({
    Key? key,
    required this.basketCount,
    required this.scrollController,
    required this.showOnOffset,
    required this.onArrowClick,
    required this.onBasketClick,
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

  late AnimationController _arrowController;
  late Animation<double> _arrowAnimation;
  late AnimationController _basketController;
  late Animation<double> _basketAnimation;
  late Animation<Size?> _sizeAnimation;
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
    _sizeAnimation =
        SizeTween(begin: Size.zero, end: Size(_fabSize, _fabSize)).animate(_basketAnimation);
  }

  @override
  void dispose() {
    _arrowController.dispose();
    _basketController.dispose();
    super.dispose();
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
    if (oldWidget.basketCount != widget.basketCount && oldWidget.basketCount == 0 ||
        widget.basketCount == 0) {
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
                foregroundColor: theme.colorScheme.onPrimary,
                backgroundColor: theme.colorScheme.primaryContainer,
                elevation: 4,
              ),
              child: const Icon(Icons.keyboard_arrow_up),
            ),
          ),
        ),
        // TODO: CRUTCH with animation of width form 0 to fixed fab width, to make the parent resize, that get an animation of the arrow shift when fab appears/disappears
        AnimatedBuilder(
          animation: _sizeAnimation,
          builder: (context, child) {
            return SizedBox.fromSize(
              size: _sizeAnimation.value,
              child: child,
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
                    onPressed: widget.onBasketClick,
                    child: const Icon(Icons.shopping_cart),
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
