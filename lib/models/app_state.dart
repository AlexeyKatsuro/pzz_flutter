import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:pzz/domain/error/scoped_error_hub.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/home_page_state.dart';
import 'package:pzz/models/navigation/navigation_state.dart';
import 'package:pzz/models/person_info/personal_info_state.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/routes.dart';

@immutable
class AppState {
  const AppState({
    required this.homePageState,
    required this.personalInfoState,
    required this.pizzas,
    required this.sauce,
    required this.basket,
    required this.isConfirmLoading,
    required this.scopedErrors,
    required this.navigationState,
    required this.locale,
  });

  factory AppState.initial({
    HomePageState? homePageState,
    PersonalInfoState? personalInfoState,
    List<Pizza>? pizzas,
    List<Sauce>? sauce,
    Basket? basket,
    bool? isConfirmLoading,
    ScopedErrorsHub? scopedErrors,
    NavigationState? navigationState,
    Locale? locale,
  }) {
    return AppState(
        homePageState: homePageState ?? const HomePageState.initial(),
        personalInfoState: personalInfoState ?? const PersonalInfoState.initial(),
        pizzas: pizzas ?? const [],
        sauce: sauce ?? const [],
        basket: basket ?? const Basket.initial(),
        isConfirmLoading: isConfirmLoading ?? false,
        scopedErrors: scopedErrors ?? const ScopedErrorsHub.initial(),
        navigationState: navigationState ?? NavigationState.initial(initialRoute: Routes.homeScreen),
        locale: locale);
  }

  final HomePageState homePageState;
  final PersonalInfoState personalInfoState;
  final List<Pizza> pizzas;
  final List<Sauce> sauce;
  final Basket basket;
  final bool isConfirmLoading; // TODO use local loading flags on App level
  final ScopedErrorsHub scopedErrors;
  final NavigationState navigationState;
  final Locale? locale;
}
