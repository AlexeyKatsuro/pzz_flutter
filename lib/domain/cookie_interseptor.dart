import 'package:http_interceptor/http_interceptor.dart';
import 'package:pzz/domain/session_bearer.dart';

class SessionCookiesInterceptor implements InterceptorContract {
  static const PHPSESSID = "PHPSESSID";
  static const COOKIE = "Cookie";
  static const SET_COOKIE = "set-cookie";

  SessionCookiesInterceptor(this._sessionBearer);

  SessionBearer _sessionBearer;

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    if (_sessionBearer.isTokenValid()) {
      try {
        data.headers[COOKIE] = _sessionBearer.token;
      } catch (e) {
        print(e);
      }
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    if (!_sessionBearer.isTokenValid()) {
      final setCookieHeader = data.headers[SET_COOKIE];
      _sessionBearer.token = setCookieHeader.split(';').firstWhere((element) => element.contains(PHPSESSID));
    }
    return data;
  }
}
