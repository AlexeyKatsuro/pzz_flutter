import 'dart:developer';

import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    log('REQUEST ----->');
    log('${data.method} ${data.baseUrl}');
    log('HEADERS:');
    log('${data.headers}');
    log('PARAMS:');
    log('${data.params}');
    log('BODY:');
    log('${data.body}');
    log('<-----REQUEST');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    log('RESPONSE ----->');
    log('${data.method} ${data.url}');
    log('HEADERS:');
    log('${data.headers}');
    log('BODY:');
    log('${data.body}');
    log('STATUS CODE ${data.statusCode}');
    log('<----- RESPONSE');
    return data;
  }
}
