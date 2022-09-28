// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$isLoadingAtom = Atom(name: 'HomeStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(name: 'HomeStoreBase.errorMessage', context: context);

  @override
  UiMessage? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(UiMessage? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$pizzasAtom = Atom(name: 'HomeStoreBase.pizzas', context: context);

  @override
  List<Pizza> get pizzas {
    _$pizzasAtom.reportRead();
    return super.pizzas;
  }

  @override
  set pizzas(List<Pizza> value) {
    _$pizzasAtom.reportWrite(value, super.pizzas, () {
      super.pizzas = value;
    });
  }

  late final _$_fetchPizzasAsyncAction =
      AsyncAction('HomeStoreBase._fetchPizzas', context: context);

  @override
  Future<void> _fetchPizzas() {
    return _$_fetchPizzasAsyncAction.run(() => super._fetchPizzas());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
pizzas: ${pizzas}
    ''';
  }
}
