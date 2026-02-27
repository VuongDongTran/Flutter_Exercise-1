import 'dart:async';
import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../app_dependency.dart';
import '../../common/constants.dart';
import '../../preferences/user_preference.dart';
import '../../routers/route_key.dart';
import '../logger.dart';
import '../restful/error_handler.dart';
import '../restful/rest_utility.dart';
import '../utils/global_key.dart';

class AuthInterceptor extends Interceptor {

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final storage = AppDependencies.injector.get<UserPreference>();
    final token = await storage.getValue(UserSharedPreferencesPath.token);

    if (StringUtils.isNotNullOrEmpty(token)) {
      options.headers['Authorization'] = 'Bearer $token';
    } else {}
    super.onRequest(options, handler);
  }
}

class TokenInterceptor extends QueuedInterceptor {
  final prefs = AppDependencies.injector.get<UserPreference>();

  Future<Map<String, dynamic>?> getToken() async {
    final Map<String, String> params = <String, String>{};
    final tokenDio = AppDependencies.injector
        .get<RestUtils>(instanceName: InstanceResflul.instanceAuth);
    String refreshToken =
        await prefs.getValue(UserSharedPreferencesPath.refreshToken);
    String accessToken = await prefs.getValue(UserSharedPreferencesPath.token);
    params['refreshToken'] = refreshToken;
    params['accessToken'] = accessToken;
    try {
      final response =
          await tokenDio.dio.post<dynamic>(ApiPath.refreshToken, data: params);
      var responseDecode =
          jsonDecode(response.data.toString()) as Map<String, dynamic>;
      if (response.statusCode == ExceptionHandle.success) {
        await prefs.setValue(UserSharedPreferencesPath.token,
            responseDecode['result']['accessToken'] ?? '');
        await prefs.setValue(UserSharedPreferencesPath.refreshToken,
            responseDecode['result']['refreshToken'] ?? '');
        await prefs.setValue(UserSharedPreferencesPath.tokenExpireAt,
            responseDecode['result']['accessTokenExpireAt'] ?? '');
        return responseDecode;
      }
    } catch (e) {
      LoggerUtils.e('Error: ${e.toString()}');
    }

    return null;
  }

  @override
  Future<void> onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == ExceptionHandle.unauthorized) {
      final RestUtils restUtils = AppDependencies.injector
          .get<RestUtils>(instanceName: InstanceResflul.instanceAuth);
      final Map<String, dynamic>? token = await getToken();
      debugPrint('REFRESHTOKEN====$token');
      if (token == null) {
        debugPrint('REFRESHTOKENKKK====$token');
        await prefs.setValue(UserSharedPreferencesPath.token, '');
        await prefs.setValue(UserSharedPreferencesPath.refreshToken, '');
        await prefs.setValue(UserSharedPreferencesPath.tokenExpireAt, '');
        await navigatorKey.currentState
            ?.pushReplacementNamed(RouteKey.login);
        return;
      }

      final String? accessToken = token['result']['accessToken'];
      final String? refreshToken = token['result']['refreshToken'];

      if (StringUtils.isNotNullOrEmpty(accessToken)) {
        await prefs.setValue(
            UserSharedPreferencesPath.token, accessToken ?? '');
        await prefs.setValue(
            UserSharedPreferencesPath.refreshToken, refreshToken ?? '');
        final Dio dio = Dio();
        dio.options = restUtils.dio.options;
        final RequestOptions request = response.requestOptions;
        request.headers['Authorization'] = 'Bearer $accessToken';

        final Options options = Options(
          headers: request.headers,
          method: request.method,
        );

        try {
          final Response response = await dio.request<dynamic>(
            request.path,
            data: request.data,
            queryParameters: request.queryParameters,
            cancelToken: request.cancelToken,
            options: options,
            onReceiveProgress: request.onReceiveProgress,
          );
          return handler.next(response);
        } on DioException catch (e) {
          return handler.reject(e);
        }
      }
      return handler.next(response);
    }
    super.onResponse(response, handler);
  }
}

class AMSDefaultHeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.remove('User-Agent');
    super.onRequest(options, handler);
  }
}

class ErrorAdapterInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Response r = _adapterData(response);
    super.onResponse(r, handler);
  }

  Response _adapterData(Response response) {
    String? content = response.data?.toString();
    if (response.statusCode == ExceptionHandle.badRequest &&
        StringUtils.isNotNullOrEmpty(content)) {
      final data = '[${jsonEncode(jsonDecode(content ?? ''))}]';
      response.data = data
          .replaceAll('errorCode', 'ErrorCode')
          .replaceAll('errorMessage', 'ErrorMessage');
    }
    return response;
  }
}
