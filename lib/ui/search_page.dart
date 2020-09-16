import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/street.dart';
import 'package:pzz/res/strings.dart';
import 'package:redux/redux.dart';

class SearchPage extends StatelessWidget {
  final queryTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) {
        final streetTitle = personalInfoStreetSelector(store.state).title;
        queryTextController.text = streetTitle;
        store.dispatch(PerformStreetSearchAction(streetTitle));
      },
      converter: _ViewModel.fromStore,
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

  Widget _buildItems(BuildContext context, int index, _ViewModel vm) {
    final item = vm.items[index];
    return Card(
      child: InkWell(
        onTap: () {
          vm.onStreetClick(item);
          Navigator.pop(context); // TODO, do navigation by Redux.
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 12, 16),
          child: Text(
            item.title,
          ),
        ),
      ),
    );
  }
}

class _ViewModel {
  final List<Street> items;
  final void Function(String query) onTyping;
  final void Function(Street street) onStreetClick;

  _ViewModel({
    @required this.items,
    @required this.onTyping,
    @required this.onStreetClick,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      items: suggestedStreetSelector(store.state),
      onTyping: (query) => store.dispatch(PerformStreetSearchAction(query)),
      onStreetClick: (street) => store.dispatch(SelectStreetAction(street)),
    );
  }
}
