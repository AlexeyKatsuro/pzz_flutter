import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/routes.dart';
import 'package:pzz/theme.dart';
import 'package:pzz/ui/basket_page.dart';
import 'package:pzz/ui/home_page.dart';
import 'package:pzz/ui/person_info_page.dart';
import 'package:pzz/ui/sauces_page.dart';
import 'package:redux/redux.dart';

class PzzApp extends StatelessWidget {
  final Store<AppState> store;

  const PzzApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: pzzTheme,
        initialRoute: Routes.homeScreen,
        routes: {
          Routes.homeScreen: (context) => HomePage(
                onInit: () {
                  store.dispatch(InitialAction(scope: Routes.homeScreen));
                },
              ),
          Routes.basketScreen: (context) => BasketPage(),
          Routes.personalInfoScreen: (context) => PersonalInfoPage(),
          Routes.saucesScreen: (context) => SaucesPage(),
        },
      ),
    );
  }
}
