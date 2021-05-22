import 'dart:ui';

import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/error/scoped_error_hub_reducer.dart';
import 'package:pzz/domain/reducers/basket_reducer.dart';
import 'package:pzz/domain/reducers/home_page_reducer.dart';
import 'package:pzz/domain/reducers/navigation_reducer.dart';
import 'package:pzz/domain/reducers/personal_info_reducer.dart';
import 'package:pzz/domain/reducers/pizzas_reducer.dart';
import 'package:pzz/domain/reducers/sauces_reducer.dart';
import 'package:pzz/models/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    scopedErrors: scopedErrorHubReducer(state.scopedErrors, action),
    homePageState: homePageStateReducer(state.homePageState, action),
    pizzas: pizzasReducer(state.pizzas, action),
    sauce: saucesReducer(state.sauce, action),
    basket: basketReducer(state.basket, action),
    personalInfoState: personalInfoStateReducer(state.personalInfoState, action),
    isConfirmLoading: _confirmLoadingReducer(state.isConfirmLoading, action),
    navigationStack: navigationStackReducer(state.navigationStack, action),
    locale: _localeReducer(state.locale, action),
  );
}

bool _confirmLoadingReducer(bool previousValue, dynamic action) {
  if (action is ConfirmLoadingAction) {
    return action.isLoading;
  } else {
    return previousValue;
  }
}

Locale? _localeReducer(Locale? locale, dynamic action) {
  if (action is ChangeLocaleAction) {
    return action.locale;
  } else {
    return locale;
  }
}
