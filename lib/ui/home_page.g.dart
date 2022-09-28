// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$_ViewModel on _ViewModelBase, Store {
  Computed<List<MapEntry<Pizza, CombinedBasketProduct?>>>? _$pizzasComputed;

  @override
  List<MapEntry<Pizza, CombinedBasketProduct?>> get pizzas => (_$pizzasComputed ??=
          Computed<List<MapEntry<Pizza, CombinedBasketProduct?>>>(() => super.pizzas,
              name: '_ViewModelBase.pizzas'))
      .value;
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading =>
      (_$loadingComputed ??= Computed<bool>(() => super.loading, name: '_ViewModelBase.loading'))
          .value;
  Computed<int>? _$basketCountComputed;

  @override
  int get basketCount => (_$basketCountComputed ??=
          Computed<int>(() => super.basketCount, name: '_ViewModelBase.basketCount'))
      .value;
  Computed<UiMessage?>? _$errorMessageComputed;

  @override
  UiMessage? get errorMessage => (_$errorMessageComputed ??=
          Computed<UiMessage?>(() => super.errorMessage, name: '_ViewModelBase.errorMessage'))
      .value;
  Computed<bool>? _$isBasketButtonVisibleComputed;

  @override
  bool get isBasketButtonVisible =>
      (_$isBasketButtonVisibleComputed ??= Computed<bool>(() => super.isBasketButtonVisible,
              name: '_ViewModelBase.isBasketButtonVisible'))
          .value;
  Computed<int>? _$pizzasCountComputed;

  @override
  int get pizzasCount => (_$pizzasCountComputed ??=
          Computed<int>(() => super.pizzasCount, name: '_ViewModelBase.pizzasCount'))
      .value;

  @override
  String toString() {
    return '''
pizzas: ${pizzas},
loading: ${loading},
basketCount: ${basketCount},
errorMessage: ${errorMessage},
isBasketButtonVisible: ${isBasketButtonVisible},
pizzasCount: ${pizzasCount}
    ''';
  }
}
