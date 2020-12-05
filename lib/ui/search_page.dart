import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/person_info_form/actions/person_info_form_actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/person_info/house.dart';
import 'package:pzz/models/person_info/street.dart';
import 'package:pzz/res/strings.dart';
import 'package:redux/redux.dart';

class SearchStreetPage<T, VM extends SearchViewModel<T>> extends StatefulWidget {
  final VM Function(Store<AppState> store) fromStore;
  final String prefill;
  final String Function(T item) stringify;

  SearchStreetPage({
    @required this.fromStore,
    @required this.prefill,
    @required this.stringify,
  });

  @override
  _SearchStreetPageState<T, VM> createState() => _SearchStreetPageState<T, VM>();
}

class _SearchStreetPageState<T, VM extends SearchViewModel<T>> extends State<SearchStreetPage<T, VM>> {
  final queryTextController = TextEditingController();

  @override
  void dispose() {
    queryTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VM>(
      onInitialBuild: (viewModel) {
        queryTextController.text = widget.prefill;
        viewModel.onTyping(widget.prefill);
        viewModel.onInitialBuild?.call();
      },
      converter: widget.fromStore,
      builder: (context, vm) {
        return _build(context, vm);
      },
    );
  }

  Widget _build(BuildContext context, VM vm) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: CupertinoTextField(
          autofocus: true,
          controller: queryTextController,
          placeholder: StringRes.search,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
          ),
          prefix: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(Icons.search),
          ),
          onChanged: vm.onTyping,
          clearButtonMode: OverlayVisibilityMode.editing,
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) => _buildItems(context, index, vm),
        separatorBuilder: (context, index) => SizedBox(height: 4),
        itemCount: vm.items.length,
      ),
    );
  }

  Widget _buildItems(BuildContext context, int index, SearchViewModel<T> vm) {
    final item = vm.items[index];
    return Card(
      child: InkWell(
        onTap: () {
          vm.onItemClick(item);
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            widget.stringify(item),
          ),
        ),
      ),
    );
  }
}

class SearchViewModel<T> {
  SearchViewModel({
    @required this.items,
    @required this.onTyping,
    @required this.onItemClick,
    this.onInitialBuild,
  });

  final List<T> items;
  final void Function(String query) onTyping;
  final void Function(T item) onItemClick;
  final VoidCallback onInitialBuild;
}

class StreetsSearchViewModel extends SearchViewModel<Street> {
  StreetsSearchViewModel({
    @required List<Street> items,
    @required void Function(String query) onTyping,
    @required void Function(Street item) onItemClick,
  }) : super(items: items, onItemClick: onItemClick, onTyping: onTyping);

  static StreetsSearchViewModel fromStore(Store<AppState> store) {
    return StreetsSearchViewModel(
      onItemClick: (item) => store.dispatch(SelectStreetAction(item)),
      onTyping: (query) => store.dispatch(PerformStreetSearchAction(query)),
      items: suggestedStreetsSelector(store.state),
    );
  }
}

class HousesSearchViewModel extends SearchViewModel<House> {
  HousesSearchViewModel({
    @required List<House> items,
    @required void Function(String query) onTyping,
    @required void Function(House item) onItemClick,
    @required VoidCallback onInitialBuild,
  }) : super(
          items: items,
          onItemClick: onItemClick,
          onTyping: onTyping,
          onInitialBuild: onInitialBuild,
        );

  static HousesSearchViewModel fromStore(Store<AppState> store) {
    final street = personalInfoStreetSelector(store.state);
    final totalHouses = totalHousesSelector(store.state);
    return HousesSearchViewModel(
      onInitialBuild: totalHouses.isEmpty ? () => store.dispatch(LoadHousesAction(street.id)) : null,
      onItemClick: (item) => store.dispatch(SelectHouseAction(item)),
      onTyping: (query) => store.dispatch(PerformHouseSearchAction(query)),
      items: suggestedHousesSelector(store.state),
    );
  }
}
