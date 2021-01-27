import 'package:flutter/foundation.dart';

@immutable
class NavigationStack {
  const NavigationStack(this.backStack);

  final List<NavStackEntry> backStack;

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
