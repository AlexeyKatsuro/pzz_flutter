import 'dart:io';

import 'package:flutter/foundation.dart';
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

import 'domain/middleware/epics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };

  final pzzRepository = getIt<PzzRepository>();
  final preferenceRepository = getIt<PreferenceRepository>();

  final epicMiddleware = EpicMiddleware(createAppEpic(pzzRepository, preferenceRepository));
  final middleware = createPzzMiddleware(pzzRepository, preferenceRepository) + [epicMiddleware];
  runApp(
    PzzApp(
      store: Store<AppState>(
        appReducer,
        initialState: AppState.initial(),
        middleware: middleware,
      ),
    ),
  );
}
