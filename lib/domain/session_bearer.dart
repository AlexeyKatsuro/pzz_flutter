import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionBearer {
  String token;

  bool isTokenValid();
}

class SessionBearerImpl extends SessionBearer {
  static const _token_key = 'token_key';

  final SharedPreferences preferences;

  SessionBearerImpl(this.preferences);

  String get token => preferences.getString(_token_key);
  set token(String value) => preferences.setString(_token_key, value);

  @override
  bool isTokenValid() => token != null && token.isNotEmpty;
}
