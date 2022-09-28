import 'package:pzz/domain/actions/navigation_actions.dart';
import 'package:pzz/models/navigation/navigation_stack.dart';
import 'package:pzz/models/navigation/navigation_state.dart';
import 'package:redux/redux.dart';

final navigationStackReducer = combineReducers<NavigationState>([
  TypedReducer<NavigationState, NavigatePushAction>(_navigatePushReducer),
  TypedReducer<NavigationState, NavigatePopAction>(_navigatePopReducer),
  TypedReducer<NavigationState, NavigateReplaceAction>(_navigateReplaceReducer),
  TypedReducer<NavigationState, NavigatePopUntilAction>(_navigatePopUntilReducer),
  TypedReducer<NavigationState, NavigatePushAndRemoveUntilAction>(
    _navigatePushAndRemoveUntilReducer,
  ),
]);

NavigationState _navigatePushReducer(NavigationState state, NavigatePushAction action) {
  return state.copyWith(
    history: state.history.copy(
      (previousStack) {
        return previousStack..add(NavDestination(name: action.name, args: action.arguments));
      },
    ),
  );
}

NavigationState _navigatePopReducer(NavigationState state, NavigatePopAction action) {
  return state.copyWith(
    history: state.history.copy(
      (previousStack) => previousStack..removeLast(),
    ),
  );
}

NavigationState _navigateReplaceReducer(NavigationState state, NavigateReplaceAction action) {
  return state.copyWith(
    history: state.history.copy(
      (previousStack) {
        return previousStack
          ..removeLast()
          ..add(NavDestination(name: action.name, args: action.arguments));
      },
    ),
  );
}

NavigationState _navigatePopUntilReducer(NavigationState state, NavigatePopUntilAction action) {
  return state.copyWith(
    history: state.history.copy(
      (previousStack) {
        return previousStack..removeUntil(action.name, inclusive: action.inclusive);
      },
    ),
  );
}

NavigationState _navigatePushAndRemoveUntilReducer(
  NavigationState state,
  NavigatePushAndRemoveUntilAction action,
) {
  return state.copyWith(
    history: state.history.copy(
      (previousStack) {
        return previousStack
          ..removeUntil(action.removeUntilPage, inclusive: action.inclusive)
          ..add(NavDestination(name: action.name, args: action.arguments));
      },
    ),
  );
}

extension on List<NavDestination> {
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
