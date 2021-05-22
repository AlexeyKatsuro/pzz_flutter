import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:pzz/domain/session_bearer.dart';

class SessionCookiesInterceptor implements InterceptorContract {
  SessionCookiesInterceptor(this._sessionBearer);

  static const PHPSESSID = 'PHPSESSID';
  static const COOKIE = 'Cookie';
  static const SET_COOKIE = 'set-cookie';

  final SessionBearer _sessionBearer;

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    if (_sessionBearer.isTokenValid()) {
      try {
        final token = _sessionBearer.token;
        if (token != null) {
          data.headers[COOKIE] = token;
        }
      } catch (e) {
        debugPrint('$e');
      }
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (!_sessionBearer.isTokenValid()) {
      final setCookieHeader = data.headers?[SET_COOKIE];
      if (setCookieHeader != null) {
        _sessionBearer.token = setCookieHeader.split(';').firstWhere((element) => element.contains(PHPSESSID));
      }
    }
    return data;
  }
}
