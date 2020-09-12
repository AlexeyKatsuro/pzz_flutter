import 'package:flutter/cupertino.dart';
import 'package:pzz/models/personal_info.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/pizza.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Pizza> pizzas;
  final List<Sauce> sauce;
  final Basket basket;
  final PersonalInfo personalInfo;

  AppState({
    this.isLoading = false,
    this.pizzas = const [],
    this.sauce = const [],
    this.basket = const Basket(),
    this.personalInfo = const PersonalInfo(),
  })  : assert(pizzas != null),
        assert(basket != null),
        assert(sauce != null),
        assert(personalInfo != null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          pizzas == other.pizzas &&
          basket == other.basket;

  @override
  int get hashCode => isLoading.hashCode ^ pizzas.hashCode ^ basket.hashCode;
}
