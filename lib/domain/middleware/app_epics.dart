import 'package:pzz/domain/middleware/epics/load_basket_epics.dart';
import 'package:pzz/domain/middleware/epics/perform_street_search_epic.dart';
import 'package:pzz/domain/middleware/epics/routed_epic.dart';
import 'package:pzz/domain/repository/preference_repository.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/routes.dart';
import 'package:redux_epics/redux_epics.dart';

Epic<AppState> createAppEpic(PzzRepository pzzRepository, PreferenceRepository preferenceRepository) {
  return combineEpics<AppState>([
    PerformStreetSearchEpic(pzzRepository),
    RoutedEpic(
      epic: LoadBasketEpics(repository: pzzRepository, scope: Routes.basketScreen),
      matcher: navMatcherBuilder(
        startEpicChecker: startCheck(Routes.basketScreen),
        stopEpicChecker: leaveCheck(Routes.basketScreen),
      ),
    ),
  ]);
}
