import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:pzz/models/navigation/navigation_stack.dart';
import 'package:pzz/routes.dart';
import 'package:pzz/stores/navigation_store.dart';
import 'package:pzz/ui/basket_page.dart';
import 'package:pzz/ui/containers/confirm_place_order_container.dart';
import 'package:pzz/ui/dev_page.dart';
import 'package:pzz/ui/home_page.dart';
import 'package:pzz/ui/not_found_page.dart';
import 'package:pzz/ui/person_info_page.dart';
import 'package:pzz/ui/sauces_page.dart';
import 'package:pzz/ui/widgets/success_order_dialog.dart';
import 'package:pzz/utils/widgets/bottom_sheet_route.dart';
import 'package:pzz/utils/widgets/dialog_route.dart';
import 'package:pzz/utils/widgets/system_ui.dart';

part 'main_navigation_container.g.dart';

typedef WidgetArgBuild<T> = Widget Function(T args);

class MainNavigationShell extends StatelessWidget {
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
    Routes.successOrderPlacedDialog: _PageBuilder<int>(
      widgetBuilder: (arg) => SuccessOrderDialog(
        freeAfterMinute: arg,
      ),
      builder: _buildBottomSheetDialog,
    ),
    Routes.confirmPlaceOrderDialog: _PageBuilder(
      widgetBuilder: (_) => ConfirmPlaceOrderDialog(),
      builder: _buildScrollBottomSheetDialog,
    ),
    Routes.devScreen: _PageBuilder(widgetBuilder: (_) => DevPage(), builder: _buildBasePage)
  };

  @override
  Widget build(BuildContext context) {
    final viewModel = _ViewModel(navigationStore: Provider.of<NavigationStore>(context));
    return WillPopScope(
      onWillPop: () async {
        return !await _navigatorKey.currentState!.maybePop();
      },
      child: Observer(
        builder: (context) {
          return Navigator(
            key: _navigatorKey,
            pages: viewModel.navigationStack.map(buildPage).toList(growable: false),
            onPopPage: (route, result) {
              if (!route.didPop(result)) return false;
              viewModel.onPopPage();
              return true;
            },
          );
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

  // ignore: unused_element
  static MaterialDialogPage<T> _buildBaseDialog<T>(
    NavDestination destination,
    WidgetArgBuild<T> builder,
  ) {
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
        child: builder(destination.args as T),
      ),
    );
  }

  static BottomSheetDialog _buildScrollBottomSheetDialog<T>(
    NavDestination destination,
    WidgetArgBuild<T> builder,
  ) {
    return BottomSheetDialog(
      key: Key(destination.name) as LocalKey?,
      name: destination.name,
      arguments: destination.args,
      isScrollControlled: true,
      child: SystemUi(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        child: builder(destination.args as T),
      ),
    );
  }

  static BottomSheetDialog _buildBottomSheetDialog<T>(
    NavDestination destination,
    WidgetArgBuild<T> builder,
  ) {
    return BottomSheetDialog(
      key: Key(destination.name) as LocalKey?,
      name: destination.name,
      arguments: destination.args,
      child: SystemUi(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        child: builder(destination.args as T),
      ),
    );
  }
}

class _ViewModel = _ViewModelBase with _$_ViewModel;

abstract class _ViewModelBase with Store {
  _ViewModelBase({required NavigationStore navigationStore}) : _navigationStore = navigationStore;

  final NavigationStore _navigationStore;

  @computed
  List<NavDestination> get navigationStack => _navigationStore.backStack;

  void onPopPage() {
    _navigationStore.pop();
  }
}

class _PageBuilder<T> {
  _PageBuilder({
    required this.widgetBuilder,
    required this.builder,
  });

  _PageBuilder.unknown()
      : widgetBuilder = ((_) => NotFoundPage()),
        builder = MainNavigationShell._buildBasePage;

  final WidgetArgBuild<T> widgetBuilder;
  final Page Function(NavDestination arguments, WidgetArgBuild<T> builder) builder;

  Page build(NavDestination destination) => builder(destination, widgetBuilder);
}
