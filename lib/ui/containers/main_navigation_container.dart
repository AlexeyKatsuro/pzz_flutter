import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/navigation_actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/navigation/navigation_stack.dart';
import 'package:pzz/routes.dart';
import 'package:pzz/ui/basket_page.dart';
import 'package:pzz/ui/containers/confirm_place_order_container.dart';
import 'package:pzz/ui/dev_page.dart';
import 'package:pzz/ui/home_page.dart';
import 'package:pzz/ui/not_found_page.dart';
import 'package:pzz/ui/person_info_page.dart';
import 'package:pzz/ui/sauces_page.dart';
import 'package:pzz/utils/widgets/bottom_sheet_route.dart';
import 'package:pzz/utils/widgets/dialog_route.dart';
import 'package:pzz/utils/widgets/system_ui.dart';
import 'package:redux/redux.dart';

typedef WidgetArgBuild<T> = Widget Function(T? args);

class MainNavigationContainer extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  final Map<String, _PageBuilder> routes = {
    Routes.homeScreen: _PageBuilder(
      widgetBuilder: (_) => HomePage(),
      builder: _buildBasePage,
    ),
    Routes.basketScreen: _PageBuilder(
      widgetBuilder: (_) => BasketPage(),
      builder: _buildBasePage,
    ),
    Routes.personalInfoScreen: _PageBuilder(
      widgetBuilder: (_) => PersonalInfoPage(),
      builder: _buildBasePage,
    ),
    Routes.saucesScreen: _PageBuilder(
      widgetBuilder: (_) => SaucesPage(),
      builder: _buildBasePage,
    ),
    Routes.successOrderPlacedDialog: _PageBuilder(
      widgetBuilder: (_) => AlertDialog(
        title: const Text('Text'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('OK'),
          )
        ],
      ),
      builder: _buildBaseDialog,
    ),
    Routes.confirmPlaceOrderDialog: _PageBuilder(
      widgetBuilder: (_) => ConfirmPlaceOrderDialog(),
      builder: buildScrollBottomSheetDialog,
    ),
    Routes.devScreen: _PageBuilder(widgetBuilder: (_) => DevPage(), builder: _buildBasePage)
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
        return !await _navigatorKey.currentState!.maybePop();
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

  Page buildPage(NavDestination destination) {
    final _PageBuilder pageBuilder = routes[destination.name] ?? _PageBuilder.unknown();
    return pageBuilder.build(destination);
  }

  static MaterialPage<T> _buildBasePage<T>(NavDestination destination, WidgetArgBuild<T> builder) {
    return MaterialPage(
      key: Key(destination.name) as LocalKey?,
      child: SystemUi(
        child: builder(destination.args as T),
      ),
    );
  }

  static MaterialDialogPage<T> _buildBaseDialog<T>(NavDestination destination, WidgetArgBuild builder) {
    return MaterialDialogPage<T>(
      key: Key(destination.name) as LocalKey?,
      name: destination.name,
      arguments: destination.args,
      child: SystemUi(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black54,
        statusBarColor: Colors.transparent,
        child: builder(destination.args),
      ),
    );
  }

  static BottomSheetDialog<T> buildScrollBottomSheetDialog<T>(NavDestination destination, WidgetArgBuild builder) {
    return BottomSheetDialog<T>(
      key: Key(destination.name) as LocalKey?,
      name: destination.name,
      arguments: destination.args,
      isScrollControlled: true,
      child: SystemUi(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        child: builder(destination.args),
      ),
    );
  }
}

class _ViewModel {
  _ViewModel({
    required this.navigationStack,
    required this.onPopPage,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      navigationStack: navigationStackSelector(store.state),
      onPopPage: () => store.dispatch(NavigateAction.pop()),
    );
  }

  final NavigationStack navigationStack;
  final VoidCallback onPopPage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel && runtimeType == other.runtimeType && navigationStack == other.navigationStack;

  @override
  int get hashCode => navigationStack.hashCode;
}

class _PageBuilder<T> {
  _PageBuilder({
    required this.widgetBuilder,
    required this.builder,
  });

  _PageBuilder.unknown()
      : widgetBuilder = ((_) => NotFoundPage()),
        builder = MainNavigationContainer._buildBasePage;

  final WidgetArgBuild<T> widgetBuilder;
  final Page<T> Function(NavDestination arguments, WidgetArgBuild<T> builder) builder;

  Page<T> build(NavDestination destination) => builder(destination, widgetBuilder);
}
