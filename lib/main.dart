import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pzz/app.dart';
import 'package:pzz/domain/middleware/epics.dart';
import 'package:pzz/domain/middleware/middlewares.dart';
import 'package:pzz/domain/reducers/app_state_reduser.dart';
import 'package:pzz/domain/repository/preference_repository.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/routes.dart';
import 'package:pzz/service_locator.dart';
import 'package:pzz/stores/basket_store.dart';
import 'package:pzz/stores/home_store.dart';
import 'package:pzz/stores/navigation_store.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Print stacktrace for widget exceptions.
  FlutterError.onError = (details) => FlutterError.dumpErrorToConsole(details, forceReport: true);
  await initDependencies();

  final pzzRepository = getIt<PzzRepository>();
  final preferenceRepository = getIt<PreferenceRepository>();

  final epicMiddleware = EpicMiddleware(createAppEpic(pzzRepository, preferenceRepository));
  final middleware = <Middleware<AppState>>[
    ...createPzzMiddleware(pzzRepository, preferenceRepository),
    epicMiddleware,
    LoggingMiddleware.printer(),
  ];
  // ignore: avoid_redundant_argument_values
  final mainNavigationStore = NavigationStore(initialRoute: Routes.homeScreen);
  final homeStore = HomeStore(pzzRepository: pzzRepository, navigationStore: mainNavigationStore);
  final basketStore =
      BasketStore(pzzRepository: pzzRepository, navigationStore: mainNavigationStore);
  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: homeStore),
        Provider.value(value: basketStore),
        Provider.value(value: mainNavigationStore),
      ],
      child: PzzApp(
        store: Store<AppState>(
          appReducer,
          initialState: AppState.initial(initialRoute: Routes.homeScreen),
          middleware: middleware,
        ),
      ),
    ),
  );
}
