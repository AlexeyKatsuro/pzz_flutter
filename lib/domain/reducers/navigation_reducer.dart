import 'package:pzz/domain/actions/navigation_actions.dart';
import 'package:pzz/models/navigation_stack.dart';
import 'package:redux/redux.dart';

final navigationStackReducer = combineReducers<NavigationStack>([
  TypedReducer<NavigationStack, NavigatePushAction>(_navigatePushReducer),
  TypedReducer<NavigationStack, NavigatePopAction>(_navigatePopReducer),
]);

NavigationStack _navigatePushReducer(NavigationStack navigationStack, NavigatePushAction action) {
  return navigationStack.copy((previousStack) {
    return previousStack..add(NavStackEntry(name: action.name, args: action.arguments));
  });
}

NavigationStack _navigatePopReducer(NavigationStack navigationStack, NavigatePopAction action) {
  return navigationStack.copy((previousStack) => previousStack..removeLast());
}
