import 'dart:async';
import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../logger.dart';
import 'base_response.dart';
import 'data_result.dart';
import 'error_handler.dart';

Duration _connectTimeout = const Duration(seconds: 30);
Duration _receiveTimeout = const Duration(seconds: 30);
Duration _sendTimeout = const Duration(seconds: 10);

typedef NetSuccessCallback<T> = void Function(T data);
typedef NetSuccessListCallback<T> = void Function(List<T> data);
typedef NetErrorCallback = void Function(int code, String msg);

enum CancelReason { disconnectNetwork, order }

class RestUtils {
  late Dio dio;

  RestUtils(
    String baseUrl, {
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    List<Interceptor>? interceptors,
  }) {
    final BaseOptions options = BaseOptions(
      connectTimeout: connectTimeout ?? _connectTimeout,
      receiveTimeout: receiveTimeout ?? _receiveTimeout,
      sendTimeout: sendTimeout ?? _sendTimeout,
      responseType: ResponseType.plain,
      validateStatus: (_) {
        return true;
      },
      contentType: Headers.jsonContentType,
      baseUrl: baseUrl,
    );
    dio = Dio(options);

    /// Add default header interceptor
    // dio.interceptors.add(DefaultHeaderInterceptor());

    void addInterceptor(Interceptor interceptor) {
      dio.interceptors.add(interceptor);
    }

    if (interceptors != null && interceptors.isNotEmpty) {
      interceptors.forEach(addInterceptor);
    }
  }

  Future<DataResult<DataResponse<T>>> request<T extends BaseResponseModel>(
    Method method,
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    required T Function() factory,
  }) async {
    try {
      if (!await _hasNetwork()) {
        return DataResult.failure(
            ExceptionHandle.handleError(ExceptionHandle.netError, null));
      }
      final Response<String> response = await dio.request<String>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method.value, options),
        cancelToken: cancelToken,
      );
      final statusCode = response.statusCode;
      final String dataResponse = response.data ?? '';
      if (statusCode != null &&
          statusCode >= ExceptionHandle.success &&
          statusCode < ExceptionHandle.multipleChoice) {
        final bool isCompute = dataResponse.length > 10 * 1024;
        LoggerUtils.d('isCompute:$isCompute');
        final Map<String, dynamic> mapResponse = isCompute
            ? await compute(_parseData, dataResponse)
            : _parseData(dataResponse);
        var res = DataResponse<T>.fromJson(mapResponse, factory);
        res.statusCode = response.statusCode;
        return DataResult.success(res);
      }
      return DataResult.failure(
          ExceptionHandle.handleError(statusCode, dataResponse));
    } catch (e) {
      LoggerUtils.e(e.toString());
      return DataResult.failure(ExceptionHandle.handleException(e));
    }
  }

  Future<DataResult<String>> download(
    String urlPath,
    String savePath, {
    ProgressCallback? progress,
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      if (!await _hasNetwork()) {
        return DataResult.failure(
            ExceptionHandle.handleError(ExceptionHandle.netError, null));
      }
      final response = await dio.download(urlPath, savePath,
          onReceiveProgress: progress,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          data: data,
          options: options);
      final statusCode = response.statusCode;
      if (statusCode != null &&
          statusCode >= ExceptionHandle.success &&
          statusCode < ExceptionHandle.multipleChoice) {
        return DataResult.success(savePath);
      }
      return DataResult.failure(ExceptionHandle.handleError(statusCode, null));
    } catch (e) {
      return DataResult.failure(ExceptionHandle.handleException(e));
    }
  }

  Future<bool> _hasNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Options _checkOptions(String method, Options? options) {
    options ??= Options();
    options.method = method;
    return options;
  }
}

Map<String, dynamic> _parseData(String data) {
  if (StringUtils.isNullOrEmpty(data)) return <String, dynamic>{};
  return json.decode(data) as Map<String, dynamic>;
}

enum Method { get, post, put, patch, delete, head }

extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}
