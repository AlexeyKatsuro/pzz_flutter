import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class NavigationStack {
  const NavigationStack(this.backStack);

  final List<NavStackEntry> backStack;

  bool containsPage(String pageName) => backStack.firstWhereOrNull((element) => element.name == pageName) != null;

  NavStackEntry get last => backStack.last;

  NavigationStack copy(
    List<NavStackEntry> Function(List<NavStackEntry> previousStack) reducer,
  ) {
    return NavigationStack(reducer([...backStack]));
  }
}

class NavStackEntry {
  const NavStackEntry({this.name, this.args});

  final String? name;

  final Object? args;
}
