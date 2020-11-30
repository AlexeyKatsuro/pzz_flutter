import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/navigate_to_action.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/navigation_stack.dart';
import 'package:pzz/routes.dart';
import 'package:pzz/ui/basket_page.dart';
import 'package:pzz/ui/home_page.dart';
import 'package:pzz/ui/not_found_page.dart';
import 'package:pzz/ui/person_info_page.dart';
import 'package:pzz/ui/sauces_page.dart';
import 'package:redux/redux.dart';

typedef PageBuilder = Widget Function(Object args);

class MainNavigationContainer extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  final Map<String, PageBuilder> routes = {
    Routes.homeScreen: (Object args) => HomePage(),
    Routes.basketScreen: (Object args) => BasketPage(),
    Routes.personalInfoScreen: (Object args) => PersonalInfoPage(),
    Routes.saucesScreen: (Object args) => SaucesPage(),
  };

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: _build,
    );
  }

  Widget _build(BuildContext context, _ViewModel viewModel) {
    return WillPopScope(
      onWillPop: () async {
        return !await _navigatorKey.currentState.maybePop();
      },
      child: Navigator(
        key: _navigatorKey,
        pages: viewModel.navigationStack.backStack.map(getPage).toList(growable: false),
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          viewModel.onPopPage();
          return true;
        },
      ),
    );
  }

  /// This method of creating pages allows you to set a common parent widget for each page.
  MaterialPage getPage(NavStackEntry page) {
    final pageBuilder = routes[page.name] ?? (_) => NotFoundPage();
    return MaterialPage(
      key: Key(page.name),
      child: pageBuilder(page.args),
    );
  }
}

class _ViewModel {
  _ViewModel({
    @required this.navigationStack,
    @required this.onPopPage,
  });

  final NavigationStack navigationStack;
  final VoidCallback onPopPage;

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      navigationStack: navigationStackSelector(store.state),
      onPopPage: () => store.dispatch(NavigateAction.pop()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel && runtimeType == other.runtimeType && navigationStack == other.navigationStack;

  @override
  int get hashCode => navigationStack.hashCode;
}
