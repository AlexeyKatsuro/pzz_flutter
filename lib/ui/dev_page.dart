import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/navigation_stack.dart';
import 'package:redux/redux.dart';

class DevPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (_, _ViewModel viewModel) {
        return _build(context, viewModel);
      },
    );
  }

  Widget _build(BuildContext context, _ViewModel viewModel) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.devTools),
      ),
      body: ListView(
        children: [
          for (final screen in viewModel.navigationStack.backStack)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(screen.name),
            ),
          for (final locale in AppLocalizations.supportedLocales)
            RadioListTile(
              value: locale,
              groupValue: viewModel.locale,
              onChanged: viewModel.onSetLocale,
              title: Text(_getLocaleName(localizations, locale)),
            )
        ],
      ),
    );
  }

  String _getLocaleName(AppLocalizations localizations, Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return localizations.english;
      case 'ru':
        return localizations.russian;
    }
    assert(false);
    return null;
  }
}

class _ViewModel {
  final Locale locale;
  final NavigationStack navigationStack;
  final ValueSetter<Locale> onSetLocale;

  _ViewModel({
    @required this.locale,
    @required this.onSetLocale,
    @required this.navigationStack,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      navigationStack: navigationStackSelector(store.state),
      locale: appLocaleSelector(store.state),
      onSetLocale: (value) => store.dispatch(ChangeLocaleAction(value)),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _ViewModel && runtimeType == other.runtimeType && locale == other.locale;

  @override
  int get hashCode => locale.hashCode;
}
