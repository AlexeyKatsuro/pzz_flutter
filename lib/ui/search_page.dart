import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/res/strings.dart';
import 'package:redux/redux.dart';

class SearchStreetPage<T> extends StatelessWidget {
  final queryTextController = TextEditingController();
  final dynamic Function(String query) createPerformSearchAction;
  final dynamic Function(T item) createSelectItemAction;
  final String Function(T item) itemToString;
  final List<T> Function(AppState state) itemsSelector;
  final String prefill;

  SearchStreetPage({
    @required this.createPerformSearchAction,
    @required this.createSelectItemAction,
    @required this.itemsSelector,
    @required this.itemToString,
    @required this.prefill,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel<T>>(
      onInit: (store) {
        queryTextController.text = prefill;
        store.dispatch(createPerformSearchAction(prefill));
      },
      converter: (store) {
        return _ViewModel.fromStore(
            store: store,
            createPerformSearchAction: createPerformSearchAction,
            createSelectItemAction: createSelectItemAction,
            itemsSelector: itemsSelector);
      },
      builder: (context, vm) {
        return _build(context, vm);
      },
    );
  }

  Widget _build(BuildContext context, _ViewModel vm) {
    return Scaffold(
      appBar: AppBar(
        title: CupertinoTextField(
          controller: queryTextController,
          placeholder: StringRes.search,
          prefix: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.search,
              color: Colors.black45,
            ),
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

  Widget _buildItems(BuildContext context, int index, _ViewModel<T> vm) {
    final item = vm.items[index];
    return Card(
      child: InkWell(
        onTap: () {
          vm.onItemClick(item);
          Navigator.pop(context); // TODO, do navigation by Redux.
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 12, 16),
          child: Text(
            itemToString(item),
          ),
        ),
      ),
    );
  }
}

class _ViewModel<T> {
  final List<T> items;
  final void Function(String query) onTyping;
  final void Function(T item) onItemClick;

  _ViewModel({
    @required this.items,
    @required this.onTyping,
    @required this.onItemClick,
  });

  static _ViewModel<T> fromStore<T>(
      {@required Store<AppState> store,
      @required List<T> itemsSelector(AppState state),
      @required dynamic createPerformSearchAction(String query),
      @required dynamic createSelectItemAction(T item)}) {
    return _ViewModel<T>(
      items: itemsSelector(store.state),
      onTyping: (query) => store.dispatch(createPerformSearchAction(query)),
      onItemClick: (item) => store.dispatch(createSelectItemAction(item)),
    );
  }
}
