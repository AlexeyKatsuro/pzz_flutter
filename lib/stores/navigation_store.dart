import 'package:mobx/mobx.dart';
import 'package:pzz/models/navigation/navigation_stack.dart';

part 'navigation_store.g.dart';

class NavigationStore = NavigationStoreBase with _$NavigationStore;

abstract class NavigationStoreBase with Store {
  NavigationStoreBase({String initialRoute = '/'}) {
    backStack = ObservableList.of(
      [NavDestination(name: initialRoute)],
      context: context,
    );
  }

  late final ObservableList<NavDestination> backStack;

  @action
  void push(String name, [Object? arguments]) {
    backStack.add(NavDestination(name: name, args: arguments));
  }

  @action
  void pop() {
    backStack.removeLast();
  }

  @action
  void replace(String name, [Object? arguments]) {
    backStack.removeLast();
    backStack.add(NavDestination(name: name, args: arguments));
  }

  @action
  void popUntil(String name, {bool inclusive = false}) {
    backStack.removeUntil(name, inclusive: inclusive);
  }

  @action
  void pushAndRemoveUntil(
    String name, {
    String? removeUntilPage,
    bool inclusive = false,
    Object? arguments,
  }) {
    backStack.removeUntil(removeUntilPage, inclusive: inclusive);
    backStack.add(NavDestination(name: name, args: arguments));
  }
}

extension on ObservableList<NavDestination> {
  void removeUntil(String? page, {required bool inclusive}) {
    if (page == null) return clear();
    for (int index = length - 1; index >= 0; index--) {
      if (this[index].name == page) {
        if (inclusive) {
          removeAt(index);
        }
        break;
      }
      removeAt(index);
    }
  }
}
