import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class NavigationStack {
  const NavigationStack(this.backStack);

  factory NavigationStack.initial({String initialRoute = '/'}) =>
      NavigationStack([NavDestination(name: initialRoute)]);

  final List<NavDestination> backStack;

  bool containsPage(String pageName) =>
      backStack.firstWhereOrNull((element) => element.name == pageName) != null;

  NavDestination get last => backStack.last;

  NavigationStack copy(
    List<NavDestination> Function(List<NavDestination> previousStack) reducer,
  ) {
    return NavigationStack(reducer([...backStack]));
  }

  bool isEqualsHierarchy(NavigationStack other) {
    if (identical(this, other) || backStack == other.backStack) return true;

    if (backStack.length != other.backStack.length) return false;
    for (int index = 0; index < backStack.length; index++) {
      final page = backStack[index];
      final pageOther = other.backStack[index];
      if (page.name != pageOther.name) return false;
    }
    return true;
  }
}

/// Groups together the path and arguments of a navigation destination
class NavDestination {
  const NavDestination({required this.name, this.args});

  final String name;

  final Object? args;
}
