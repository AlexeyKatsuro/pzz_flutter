import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:pzz/domain/cookie_interseptor.dart';
import 'package:pzz/domain/logging_inerceptor.dart';
import 'package:pzz/domain/pzz_net_service.dart';
import 'package:pzz/domain/repository/preference_pepository_impl.dart';
import 'package:pzz/domain/repository/preference_repository.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/domain/repository/pzz_repository_impl.dart';
import 'package:pzz/domain/session_bearer.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  getIt.registerSingleton(await SharedPreferences.getInstance());
  getIt.registerLazySingleton<SessionBearer>(() => SessionBearerImpl(getIt.get<SharedPreferences>()));
  getIt.registerLazySingleton<PzzNetService>(() => PzzNetService(getIt<http.Client>()));

  getIt.registerLazySingleton<PzzRepository>(() => PzzRepositoryImpl(getIt<PzzNetService>()));
  getIt.registerLazySingleton<PreferenceRepository>(() => PreferenceRepositoryImpl(getIt<SharedPreferences>()));
  getIt.registerLazySingleton<http.Client>(
    () => HttpClientWithInterceptor.build(
      interceptors: [
        SessionCookiesInterceptor(getIt<SessionBearer>()),
        LoggingInterceptor(),
      ],
    ),
  );
}
