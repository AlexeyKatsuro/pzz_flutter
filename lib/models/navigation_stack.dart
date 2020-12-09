import 'package:flutter/foundation.dart';

@immutable
class NavigationStack {
  final List<NavStackEntry> backStack;

  const NavigationStack(this.backStack);

  NavigationStack copy(
    List<NavStackEntry> Function(List<NavStackEntry> previousStack) reducer,
  ) {
    return NavigationStack(reducer([...backStack]));
  }
}

class NavStackEntry {
  final String name;
  final Object args;

  const NavStackEntry({this.name, this.args});
}
