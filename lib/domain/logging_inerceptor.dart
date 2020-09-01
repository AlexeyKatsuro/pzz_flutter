import 'package:flutter/cupertino.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    debugPrint('REQUEST ----->');
    debugPrint('${data.method} ${data.baseUrl}');
    debugPrint('HEADERS:');
    debugPrint('${data.headers}');
    debugPrint('PARAMS:');
    debugPrint('${data.params}');
    debugPrint('BODY:');
    debugPrint('${data.body}');
    debugPrint('<-----REQUEST');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    debugPrint('RESPONSE ----->');
    debugPrint('${data.method} ${data.url}');
    debugPrint('HEADERS:');
    debugPrint('${data.headers}');
    debugPrint('BODY:');
    debugPrint('${data.body}');
    debugPrint('STATUS CODE ${data.statusCode}');
    debugPrint('<----- RESPONSE');
    return data;
  }
}
