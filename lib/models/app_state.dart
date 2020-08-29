import 'package:flutter/cupertino.dart';
import 'package:pzz/models/pizza.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Pizza> pizzas;

  AppState({
    this.isLoading = false,
    this.pizzas = const [],
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState && runtimeType == other.runtimeType && isLoading == other.isLoading && pizzas == other.pizzas;

  @override
  int get hashCode => isLoading.hashCode ^ pizzas.hashCode;
}
