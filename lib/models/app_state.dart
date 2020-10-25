import 'package:flutter/cupertino.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/person_info/personal_info_state.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/sauce.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Pizza> pizzas;
  final List<Sauce> sauce;
  final Basket basket;
  final PersonalInfoState personalInfoState;
  final bool showConfirmOrderDialogEvent;
  final bool isConfirmLoading;

  const AppState({
    @required this.isLoading,
    @required this.pizzas,
    @required this.sauce,
    @required this.basket,
    @required this.personalInfoState,
    @required this.showConfirmOrderDialogEvent,
    @required this.isConfirmLoading,
  });

  const AppState.initial({
    this.isLoading = false,
    this.isConfirmLoading = false,
    this.pizzas = const [],
    this.sauce = const [],
    this.basket = const Basket.initial(),
    this.personalInfoState = const PersonalInfoState.initial(),
    this.showConfirmOrderDialogEvent = false,
  })  : assert(pizzas != null),
        assert(basket != null),
        assert(sauce != null),
        assert(personalInfoState != null);
}
