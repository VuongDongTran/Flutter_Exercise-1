import 'dart:convert';
import 'dart:io';
import 'package:basic_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorCode;
  final String message;

  const Failure(this.errorCode, this.message);

  @override
  List<Object> get props => [errorCode, message];
}

// General failures
class GenericFailure extends Failure {
  const GenericFailure(String errorCode, String message)
      : super(errorCode, message);
}

class ApiFailure extends Failure {
  final int statusCode;
  const ApiFailure(this.statusCode, String errorCode, String message)
      : super(errorCode, message);

  factory ApiFailure.fromJson(Map<String, dynamic> json, int statusCode) {
    return ApiFailure(statusCode, '', json['message'] ?? '');
  }
}

class ExceptionHandle {
  static const int success = 200;
  static const int successNotContent = 204;
  static const int multipleChoice = 300;
  static const int notModified = 304;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int badRequest = 400;
  static const int internalServerError = 500;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
  static const int gatewayTimeout = 504;

  static const int netError = 1000;
  static const int parseError = 1001;
  static const int socketError = 1002;
  static const int httpError = 1003;
  static const int connectTimeoutError = 1004;
  static const int sendTimeoutError = 1005;
  static const int receiveTimeoutError = 1006;
  static const int cancelError = 1007;
  static const int unknownError = 9999;

  static const String _errorMessage =
      'Không kết nối được với máy chủ\nVui lòng thử lại sau.';
  static final Map<int, ApiFailure> _errorMap = <int, ApiFailure>{
    netError: const ApiFailure(netError, 'network_error', 'network error'),
    parseError: const ApiFailure(parseError, 'parse_error', _errorMessage),
    socketError: const ApiFailure(socketError, 'socket_error', _errorMessage),
    httpError: const ApiFailure(httpError, 'http_error', _errorMessage),
    connectTimeoutError:
        const ApiFailure(connectTimeoutError, 'connect_timeout', _errorMessage),
    sendTimeoutError:
        const ApiFailure(sendTimeoutError, 'sent_timeout', _errorMessage),
    receiveTimeoutError:
        const ApiFailure(receiveTimeoutError, 'receive_timeout', _errorMessage),
    cancelError: const ApiFailure(cancelError, 'cancel_error', _errorMessage),
    internalServerError: const ApiFailure(internalServerError,
        'internal_server_error', 'Đã có lỗi xảy ra\nvui lòng thử lại sau.'),
    forbidden: const ApiFailure(
        forbidden, 'forbidden', 'Bạn không có quyền xem nội dung này.'),
    notFound:
        const ApiFailure(notFound, 'not_found', 'Không tìm thấy nội dung.'),
    badGateway: const ApiFailure(badGateway, 'bad_gateway',
        'Không kết nối được với máy chủ\nvui lòng thử lại sau.'),
    serviceUnavailable: const ApiFailure(
        serviceUnavailable,
        'service_unavailable',
        'Không kết nối được với máy chủ. Vui lòng đăng nhập lại.'),
    gatewayTimeout: const ApiFailure(gatewayTimeout, 'gateway_timeout',
        'Không nhận được phản hồi từ máy chủ\nVui lòng thử lại sau.')
  };
  static ApiFailure handleError(int? statusCode, String? data) {
    if (statusCode == badRequest && StringUtils.isNotNullOrEmpty(data)) {
      final error = jsonDecode(data!);
      final apiFailure = ApiFailure.fromJson(error, statusCode ?? 0);
      return apiFailure;
    }

    return _errorMap[statusCode] ??
        ApiFailure(
            statusCode ?? unknownError, 'unknown_error', 'Unknown Error');
  }

  static ApiFailure handleException(dynamic error) {
    if (error is DioException) {
      if (error.type.errorCode == 0) {
        return _handleException(error.error);
      } else {
        return _errorMap[error.type.errorCode]!;
      }
    } else {
      return _handleException(error);
    }
  }

  static ApiFailure _handleException(dynamic error) {
    int errorCode = unknownError;
    if (error is SocketException) {
      errorCode = socketError;
    }
    if (error is HttpException) {
      errorCode = httpError;
    }
    if (error is FormatException) {
      errorCode = parseError;
    }
    return _errorMap[errorCode] ??
        ApiFailure(errorCode, 'unknown_error', _errorMessage);
  }
}

extension DioErrorTypeExtension on DioExceptionType {
  int get errorCode => [
        ExceptionHandle.connectTimeoutError,
        ExceptionHandle.sendTimeoutError,
        ExceptionHandle.receiveTimeoutError,
        0,
        ExceptionHandle.cancelError,
        0,
      ][index];
}
