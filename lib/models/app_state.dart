import 'package:flutter/cupertino.dart';
import 'package:pzz/models/personal_info.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/models/street.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Pizza> pizzas;
  final List<Sauce> sauce;
  final Basket basket;
  final PersonalInfo personalInfo;
  final List<Street> suggestedStreets;

  AppState({
    this.isLoading = false,
    this.pizzas = const [],
    this.sauce = const [],
    this.basket = const Basket(),
    this.personalInfo = const PersonalInfo(),
    this.suggestedStreets = const [],
  })  : assert(pizzas != null),
        assert(basket != null),
        assert(sauce != null),
        assert(personalInfo != null);
}
