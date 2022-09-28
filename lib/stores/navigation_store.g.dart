// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NavigationStore on NavigationStoreBase, Store {
  late final _$NavigationStoreBaseActionController =
      ActionController(name: 'NavigationStoreBase', context: context);

  @override
  void push(String name, [Object? arguments]) {
    final _$actionInfo =
        _$NavigationStoreBaseActionController.startAction(name: 'NavigationStoreBase.push');
    try {
      return super.push(name, arguments);
    } finally {
      _$NavigationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pop() {
    final _$actionInfo =
        _$NavigationStoreBaseActionController.startAction(name: 'NavigationStoreBase.pop');
    try {
      return super.pop();
    } finally {
      _$NavigationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void replace(String name, [Object? arguments]) {
    final _$actionInfo =
        _$NavigationStoreBaseActionController.startAction(name: 'NavigationStoreBase.replace');
    try {
      return super.replace(name, arguments);
    } finally {
      _$NavigationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void popUntil(String name, {bool inclusive = false}) {
    final _$actionInfo =
        _$NavigationStoreBaseActionController.startAction(name: 'NavigationStoreBase.popUntil');
    try {
      return super.popUntil(name, inclusive: inclusive);
    } finally {
      _$NavigationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pushAndRemoveUntil(String name,
      {String? removeUntilPage, bool inclusive = false, Object? arguments}) {
    final _$actionInfo = _$NavigationStoreBaseActionController.startAction(
        name: 'NavigationStoreBase.pushAndRemoveUntil');
    try {
      return super.pushAndRemoveUntil(name,
          removeUntilPage: removeUntilPage, inclusive: inclusive, arguments: arguments);
    } finally {
      _$NavigationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
