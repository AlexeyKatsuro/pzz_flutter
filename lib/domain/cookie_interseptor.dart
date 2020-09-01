import 'package:http_interceptor/http_interceptor.dart';

class SessionCookiesInterceptor implements InterceptorContract {
  static const PHPSESSID = "PHPSESSID";
  static const COOKIE = "Cookie";
  static const SET_COOKIE = "set-cookie";

  String _phpSessionCookie;

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    if (_phpSessionCookie != null) {
      try {
        data.headers[COOKIE] = _phpSessionCookie;
      } catch (e) {
        print(e);
      }
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    if (_phpSessionCookie == null) {
      final setCookieHeader = data.headers[SET_COOKIE];
      _phpSessionCookie = setCookieHeader.split(';').firstWhere((element) => element.contains(PHPSESSID));
    }
    return data;
  }
}
