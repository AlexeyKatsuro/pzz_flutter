import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionBearer {
  String? token;

  bool isTokenValid();
}

class SessionBearerImpl extends SessionBearer {
  SessionBearerImpl(this.preferences);

  static const _token_key = 'token_key';

  final SharedPreferences preferences;

  @override
  String? get token => preferences.getString(_token_key);

  @override
  set token(String? value) {
    if (value != null) {
      preferences.setString(_token_key, value);
    } else {
      preferences.remove(_token_key);
    }
  }

  @override
  bool isTokenValid() => token != null && token!.isNotEmpty;
}
