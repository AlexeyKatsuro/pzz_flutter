import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/theme.dart';
import 'package:pzz/ui/containers/main_navigation_container.dart';
import 'package:redux/redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PzzApp extends StatelessWidget {
  final Store<AppState> store;

  PzzApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          title: 'Pzz',
          theme: PzzAppTheme.pzzLightTheme,
          darkTheme: PzzAppTheme.pzzDarkTheme,
          home: MainNavigationContainer()),
    );
  }
}
