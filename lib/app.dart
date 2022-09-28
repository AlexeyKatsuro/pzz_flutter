import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/app_option.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/actions/navigation_actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/routes.dart';
import 'package:pzz/theme.dart';
import 'package:pzz/ui/containers/main_navigation_container.dart';
import 'package:redux/redux.dart';

class PzzApp extends StatelessWidget {
  const PzzApp({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        distinct: true,
        onInit: (store) =>
            store.dispatch(InitialAction(scope: Routes.homeScreen)),
        converter: (store) => _ViewModel.fromStore(store),
        builder: (context, viewModel) {
          final navigator = MainNavigationContainer();
          Widget home;
          if (kReleaseMode) {
            home = navigator;
          } else {
            home = Stack(
              children: [
                navigator,
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          icon: const Icon(Icons.developer_mode),
                          onPressed: viewModel.onDevPageClick,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            title: 'Pzz',
            theme: PzzAppTheme.pzzLightTheme,
            darkTheme: PzzAppTheme.pzzDarkTheme,
            locale: viewModel.locale,
            localeResolutionCallback: (locale, supportedLocales) {
              final availableLocale = supportedLocales.firstWhereOrNull(
                    (supported) => _checkInitLocale(supported, locale),
                  ) ??
                  supportedLocales.first;
              deviceLocale = availableLocale;
              return availableLocale;
            },
            home: home,
          );
        },
      ),
    );
  }

  bool _checkInitLocale(Locale locale, Locale? osLocale) {
    // If suported locale not contain countryCode then check only languageCode
    if (locale.countryCode == null || osLocale!.countryCode == null) {
      return locale.languageCode == osLocale!.languageCode;
    } else {
      return locale == osLocale;
    }
  }
}

class _ViewModel {
  _ViewModel({
    required this.locale,
    required this.onSetLocale,
    required this.onDevPageClick,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      locale: appLocaleSelector(store.state),
      onSetLocale: (value) => store.dispatch(ChangeLocaleAction(value)),
      onDevPageClick: () =>
          store.dispatch(NavigateAction.push(Routes.devScreen)),
    );
  }

  final Locale? locale;
  final ValueSetter<Locale> onSetLocale;
  final VoidCallback onDevPageClick;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          locale == other.locale;

  @override
  int get hashCode => locale.hashCode;
}
