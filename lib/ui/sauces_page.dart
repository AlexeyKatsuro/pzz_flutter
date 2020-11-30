import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/actions/navigate_to_action.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/res/constants.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/routes.dart';
import 'package:pzz/ui/widgets/sauce.dart';
import 'package:pzz/utils/extensions/to_product_ext.dart';
import 'package:pzz/utils/scoped.dart';
import 'package:redux/redux.dart';

class SaucesPage extends StatelessWidget implements Scoped {
  @override
  final String scope = Routes.saucesScreen;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.fromStore(store, scope),
      builder: (_, _ViewModel viewModel) {
        return _build(context, viewModel);
      },
    );
  }

  Widget _build(BuildContext context, _ViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringRes.sauces),
        actions: [
          IconButton(
              icon: Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: viewModel.onDoneClick)
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        children: [
          AnimatedContainer(
            height: viewModel.hasFreeSauce ? 50 : 0, // TODO CRUTCH
            duration: kDurationFast,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 8),
              child: AnimatedSwitcher(
                duration: kDurationFast,
                child: viewModel.hasFreeSauce
                    ? Text(
                        StringRes.chooseFeeSauces(viewModel.freeSauceCounts),
                        style: Theme.of(context).textTheme.headline6,
                      )
                    : null,
              ),
            ),
          ),
          for (int index = 0; index < viewModel.sauces.length; index++)
            SauceWidget(
              count: viewModel.saucesCountMap[viewModel.sauces[index].id],
              isFree: viewModel.hasFreeSauce,
              item: viewModel.sauces[index],
              onAddClick: () => viewModel.onAddItemClick(viewModel.sauces[index].toProduct()),
              onRemoveClick: () => viewModel.onRemoveItemClick(viewModel.sauces[index].toProduct()),
            ),
        ],
      ),
    );
  }
}

class _ViewModel {
  const _ViewModel({
    @required this.sauces,
    @required this.saucesCountMap,
    @required this.freeSauceCounts,
    @required this.onAddItemClick,
    @required this.onRemoveItemClick,
    @required this.onDoneClick,
  }) : assert(sauces != null);

  final int freeSauceCounts;
  final List<Sauce> sauces;
  final Map<int, int> saucesCountMap;
  final ValueSetter<Product> onAddItemClick;
  final ValueSetter<Product> onRemoveItemClick;
  final VoidCallback onDoneClick;

  bool get hasFreeSauce => freeSauceCounts != 0;

  factory _ViewModel.fromStore(Store<AppState> store, String scope) {
    return _ViewModel(
      freeSauceCounts: freeSauceCountsSelector(store.state),
      saucesCountMap: saucesCountsMapSelector(store.state),
      sauces: saucesSelector(store.state),
      onAddItemClick: (item) => store.dispatch(AddProductAction(product: item, scope: scope)),
      onRemoveItemClick: (item) => store.dispatch(RemoveProductAction(product: item, scope: scope)),
      onDoneClick: () => store.dispatch(NavigateAction.pop()),
    );
  }
}
