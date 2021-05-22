import 'package:pzz/models/navigation/navigation_stack.dart';

mixin HasNavigationState {
  NavigationState get navigationState;
}

class NavigationState {
  NavigationState({
    required this.history,
  });

  factory NavigationState.initial({String initialRoute = '/'}) {
    return NavigationState(
      history: NavigationStack.initial(initialRoute: initialRoute),
    );
  }

  final NavigationStack history;

  NavigationState copyWith({
    NavigationStack? history,
  }) {
    return NavigationState(
      history: history ?? this.history,
    );
  }
}

extension NavigationStateExt on NavigationState {
  bool isEqualsHierarchy(NavigationState other) => history.isEqualsHierarchy(other.history);
}
