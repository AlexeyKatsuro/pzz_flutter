import 'package:pzz/domain/actions/navigation_actions.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:redux/redux.dart';

void navigationMiddleware(Store<AppState> store, NavigateAction action, NextDispatcher next) {
  final prevStack = navigationStackSelector(store.state);
  next(action);
  final newStack = navigationStackSelector(store.state);
  next(NavigationStackChangedAction(prevStack: prevStack, newStack: newStack));
}
