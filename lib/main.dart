import 'package:flutter/material.dart';
import 'package:pzz/app.dart';
import 'package:pzz/domain/middleware/middlewares.dart';
import 'package:pzz/domain/reducers/app_state_reduser.dart';
import 'package:pzz/domain/repository/preference_repository.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/service_locator.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(PzzApp(
    store: Store<AppState>(
      appReducer,
      initialState: AppState(isLoading: false),
      middleware: createPzzMiddleware(getIt<PzzRepository>(), getIt<PreferenceRepository>()),
    ),
  ));
}
