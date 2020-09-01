import 'package:flutter/cupertino.dart';
import 'package:pzz/models/basket.dart';
import 'package:pzz/models/pizza.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Pizza> pizzas;
  final Basket basket;

  AppState({
    this.isLoading = false,
    this.pizzas = const [],
    this.basket,
  });

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
