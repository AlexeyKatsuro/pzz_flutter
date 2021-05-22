import 'package:pzz/domain/actions/navigation_actions.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/navigation_stack.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

typedef NavMatcher<S> = RoutedEpicState Function(NavigationStack old, NavigationStack next, S state);
typedef NavChecker = bool Function(NavigationStack old, NavigationStack next);

class RoutedEpic extends EpicClass<AppState> {
  RoutedEpic({
    required this.epic,
    required this.matcher,
    this.stopEpic,
  });

  final Epic<AppState> epic;
  final Epic<AppState>? stopEpic;
  final NavMatcher matcher;

  @override
  Stream call(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions
        .whereType<NavigationStackChangedAction>()
        .map((action) => matcher(action.prevStack, action.newStack, store.state))
        .where((state) => state != RoutedEpicState.skip)
        .switchMap((state) {
      switch (state) {
        case RoutedEpicState.start:
          return epic(actions, store);
        case RoutedEpicState.stop:
          return stopEpic?.call(actions, store) ?? const Stream.empty();
        case RoutedEpicState.skip:
          return const Stream.empty(); // to be exhaustive
      }
    });
  }
}

NavMatcher<S> navMatcherBuilder<S>({
  required NavChecker startEpicChecker,
  required NavChecker stopEpicChecker,
}) {
  return (NavigationStack old, NavigationStack next, S state) {
    if (stopEpicChecker(old, next)) return RoutedEpicState.stop;
    if (startEpicChecker(old, next)) return RoutedEpicState.start;
    return RoutedEpicState.skip;
  };
}

NavChecker combineCheckerByAny(List<NavChecker> checkers) => (NavigationStack old, NavigationStack next) {
      return checkers.fold(false, (result, checker) => result || checker(old, next));
    };

NavChecker startCheck(String pageName) => (NavigationStack old, NavigationStack next) {
      return !old.containsPage(pageName) && next.containsPage(pageName);
    };

NavChecker pauseCheck(String pageName) => (NavigationStack old, NavigationStack next) {
      return old.last.name == pageName && next.containsPage(pageName) && next.last.name != pageName;
    };

NavChecker resumeCheck(String pageName) => (NavigationStack old, NavigationStack next) {
      return old.last.name == pageName && next.containsPage(pageName) && next.last.name != pageName;
    };

NavChecker leaveCheck(String pageName) => (NavigationStack old, NavigationStack next) {
      return old.containsPage(pageName) && !next.containsPage(pageName);
    };

enum RoutedEpicState {
  start,
  stop,
  skip,
}
