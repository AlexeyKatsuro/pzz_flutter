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
import 'package:pzz/utils/widgets/dialog_route.dart';
import 'package:pzz/utils/widgets/system_ui.dart';
import 'package:redux/redux.dart';

typedef WidgetArgBuild = Widget Function(Object args);

class MainNavigationContainer extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  final Map<String, _PageBuilder> routes = {
    Routes.homeScreen: _PageBuilder(
      widgetBuilder: (_) => HomePage(),
      builder: buildBasePage,
    ),
    Routes.basketScreen: _PageBuilder(
      widgetBuilder: (_) => BasketPage(),
      builder: buildBasePage,
    ),
    Routes.personalInfoScreen: _PageBuilder(
      widgetBuilder: (_) => PersonalInfoPage(),
      builder: buildBasePage,
    ),
    Routes.saucesScreen: _PageBuilder(
      widgetBuilder: (_) => SaucesPage(),
      builder: buildBasePage,
    ),
    Routes.successOrderPlacedDialog: _PageBuilder(
      widgetBuilder: (_) => AlertDialog(
        title: Text('Text'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {},
          )
        ],
      ),
      builder: buildBaseDialog,
    ),
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
        pages: viewModel.navigationStack.backStack.map(buildPage).toList(growable: false),
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          viewModel.onPopPage();
          return true;
        },
      ),
    );
  }

  Page buildPage(NavStackEntry stackEntry) {
    final _PageBuilder pageBuilder = routes[stackEntry.name] ?? _PageBuilder.unknown();
    return pageBuilder.build(stackEntry);
  }

  static MaterialPage<T> buildBasePage<T>(NavStackEntry page, WidgetArgBuild builder) {
    return MaterialPage(
      key: Key(page.name),
      child: SystemUi(
        child: builder(page.args),
      ),
    );
  }

  static MaterialDialogPage<T> buildBaseDialog<T>(NavStackEntry page, WidgetArgBuild builder) {
    return MaterialDialogPage<T>(
      key: Key(page.name),
      name: page.name,
      arguments: page.args,
      child: SystemUi(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black54,
        statusBarColor: Colors.transparent,
        child: builder(page.args),
      ),
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

class _PageBuilder<T> {
  final WidgetArgBuild widgetBuilder;
  final Page<T> Function(NavStackEntry arguments, WidgetArgBuild builder) builder;

  _PageBuilder({
    @required this.widgetBuilder,
    @required this.builder,
  });

  _PageBuilder.unknown()
      : widgetBuilder = ((_) => NotFoundPage()),
        builder = MainNavigationContainer.buildBasePage;

  Page<T> build(NavStackEntry stackEntry) => builder(stackEntry, widgetBuilder);
}
