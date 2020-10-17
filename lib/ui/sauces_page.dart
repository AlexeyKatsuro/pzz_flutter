import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/product.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/ui/widgets/sauce.dart';
import 'package:pzz/utils/extensions/to_product_ext.dart';
import 'package:redux/redux.dart';

class SaucesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (_, _ViewModel viewModel) {
        return _build(context, viewModel);
      },
    );
  }

  Widget _build(BuildContext context, _ViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringRes.sauces),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        children: [
          if (viewModel.freeSauceCounts != 0)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 8),
              child: Text(
                StringRes.chooseFeeSauces(viewModel.freeSauceCounts),
                style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black54),
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
    @required this.onAddItemClick,
    @required this.onRemoveItemClick,
    @required this.saucesCountMap,
    @required this.freeSauceCounts,
  }) : assert(sauces != null);

  final int freeSauceCounts;
  final List<Sauce> sauces;
  final Map<int, int> saucesCountMap;
  final void Function(Product) onAddItemClick;
  final void Function(Product) onRemoveItemClick;

  bool get hasFreeSauce => freeSauceCounts != 0;

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      freeSauceCounts: freeSauceCountsSelector(store.state),
      saucesCountMap: saucesCountsMapSelector(store.state),
      sauces: saucesSelector(store.state),
      onAddItemClick: (item) {
        store.dispatch(AddProductAction(item));
      },
      onRemoveItemClick: (item) {
        store.dispatch(RemoveProductAction(item));
      },
    );
  }
}
