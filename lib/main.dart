import 'package:flutter/material.dart';
import 'package:pzz/app.dart';
import 'package:pzz/domain/middleware/middlewares.dart';
import 'package:pzz/domain/reducers/app_state_reduser.dart';
import 'package:pzz/domain/repository/preference_repository.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/service_locator.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';

import 'domain/middleware/epics.dart';

// ignore: avoid_void_async
void main() async {
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
  runApp(
    PzzApp(
      store: Store<AppState>(
        appReducer,
        initialState: const AppState.initial(),
        middleware: middleware,
      ),
    ),
  );
}
