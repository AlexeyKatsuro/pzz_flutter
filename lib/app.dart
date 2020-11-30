import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/routes.dart';
import 'package:pzz/theme.dart';
import 'package:pzz/ui/basket_page.dart';
import 'package:pzz/ui/home_page.dart';
import 'package:pzz/ui/not_found_page.dart';
import 'package:pzz/ui/person_info_page.dart';
import 'package:pzz/ui/sauces_page.dart';
import 'package:pzz/utils/widgets/status_bar_brightness.dart';
import 'package:redux/redux.dart';

class PzzApp extends StatelessWidget {
  final Store<AppState> store;

  PzzApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        onGenerateRoute: (settings) => getRoute(context, settings),
        title: 'Flutter Demo',
        theme: PzzAppTheme.pzzLightTheme,
        darkTheme: PzzAppTheme.pzzDarkTheme,
        initialRoute: Routes.homeScreen,
      ),
    );
  }
}
