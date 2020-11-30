import 'package:flutter/foundation.dart';

@immutable
class NavigationStack {
  final List<NavStackEntry<Object>> backStack;

  const NavigationStack(this.backStack);

  NavigationStack copy(
    List<NavStackEntry> Function(List<NavStackEntry> previousStack) reducer,
  ) {
    return NavigationStack(reducer([...backStack]));
  }
}

class NavStackEntry<T> {
  final String name;
  final T args;

  const NavStackEntry({this.name, this.args});
}
