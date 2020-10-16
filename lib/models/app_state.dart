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

  //final PersonalInfo personalInfo;
  final PersonalInfoState personalInfoState;

  AppState({
    this.isLoading = false,
    this.pizzas = const [],
    this.sauce = const [],
    this.basket = const Basket(),
    //this.personalInfo = const PersonalInfo(),
    this.personalInfoState = const PersonalInfoState(),
  })  : assert(pizzas != null),
        assert(basket != null),
        assert(sauce != null),
        assert(personalInfoState != null);
//assert(personalInfo != null);
}
