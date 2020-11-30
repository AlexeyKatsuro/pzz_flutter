import 'package:flutter/foundation.dart';
import 'package:pzz/domain/error/scoped_error_hub.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/home_page_state.dart';
import 'package:pzz/models/navigation_stack.dart';
import 'package:pzz/models/person_info/personal_info_state.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/routes.dart';

@immutable
class AppState {
  final HomePageState homePageState;
  final PersonalInfoState personalInfoState;
  final List<Pizza> pizzas;
  final List<Sauce> sauce;
  final Basket basket;
  final bool showConfirmOrderDialogEvent;
  final bool isConfirmLoading;
  final ScopedErrorsHub scopedErrors;
  final NavigationStack navigationStack;

  const AppState({
    @required this.homePageState,
    @required this.pizzas,
    @required this.sauce,
    @required this.basket,
    @required this.personalInfoState,
    @required this.showConfirmOrderDialogEvent,
    @required this.isConfirmLoading,
    @required this.scopedErrors,
    @required this.navigationStack,
  });

  const AppState.initial({
    this.homePageState = const HomePageState.initial(),
    this.isConfirmLoading = false,
    this.pizzas = const [],
    this.sauce = const [],
    this.basket = const Basket.initial(),
    this.personalInfoState = const PersonalInfoState.initial(),
    this.showConfirmOrderDialogEvent = false,
    this.scopedErrors = const ScopedErrorsHub.initial(),
    this.navigationStack = const NavigationStack([NavStackEntry(name: Routes.homeScreen)]),
  })  : assert(homePageState != null),
        assert(isConfirmLoading != null),
        assert(pizzas != null),
        assert(sauce != null),
        assert(basket != null),
        assert(personalInfoState != null),
        assert(showConfirmOrderDialogEvent != null),
        assert(scopedErrors != null);
}
