// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_navigation_container.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$_ViewModel on _ViewModelBase, Store {
  Computed<List<NavDestination>>? _$navigationStackComputed;

  @override
  List<NavDestination> get navigationStack =>
      (_$navigationStackComputed ??= Computed<List<NavDestination>>(() => super.navigationStack,
              name: '_ViewModelBase.navigationStack'))
          .value;

  @override
  String toString() {
    return '''
navigationStack: ${navigationStack}
    ''';
  }
}
