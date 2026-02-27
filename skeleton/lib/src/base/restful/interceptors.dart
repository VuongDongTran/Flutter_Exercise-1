import 'dart:convert';

import 'package:dio/dio.dart';

import '../logger.dart';

class LoggingInterceptor extends Interceptor {
  late DateTime startTime;
  late DateTime endTime;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    startTime = DateTime.now();
    LoggerUtils.d(
        'URLRequest:: ${options.uri}:: RequestMethod: ${options.method}\n RequestHeaders:${options.headers}\n RequestContentType: ${options.contentType}\n RequestData: ${json.encode(options.data)}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    endTime = DateTime.now();
    LoggerUtils.d('ResponseCode: ${response.statusCode}\n');
    LoggerUtils.d('ResponseData: ${response.data.toString()}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    LoggerUtils.e('Error: ${err.message}');
    super.onError(err, handler);
  }
}

// class DefaultHeaderInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     String? contentType = Headers.jsonContentType;
//     if (options.contentType == null) {
//       final dynamic data = options.data;
//       if (data is FormData) {
//         contentType = Headers.multipartFormDataContentType;
//       } else if (data is Map) {
//         contentType = Headers.formUrlEncodedContentType;
//       } else if (data is String) {
//         contentType = Headers.jsonContentType;
//       } else if (data != null) {
//         contentType = Headers.textPlainContentType;
//       } else {
//         contentType = null;
//       }
//       options.contentType = contentType;
//     }
//     handler.next(options);
//   }
// }
