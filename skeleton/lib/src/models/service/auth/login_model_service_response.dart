import 'package:json_annotation/json_annotation.dart';

import '../../../base/restful/base_response.dart';

part 'login_model_service_response.g.dart';

@JsonSerializable()
class LoginModelServiceResponse extends BaseResponseModel {
  final LoginResult? result;
  final int? statusCode;
  final String? message;
  final bool? success;
  final dynamic errors;

  LoginModelServiceResponse({
    this.result,
    this.statusCode,
    this.message,
    this.success,
    this.errors,
  });

  Map<String, dynamic> toJson() => _$LoginModelServiceResponseToJson(this);

  @override
  LoginModelServiceResponse fromJson(Map<String, dynamic> json) =>
      _$LoginModelServiceResponseFromJson(json);
}

@JsonSerializable()
class LoginResult {
  final String? accessToken;
  final DateTime? accessTokenExpireAt;
  final String? refreshToken;
  final DateTime? refreshTokenExpireAt;

  const LoginResult({
    this.accessToken,
    this.accessTokenExpireAt,
    this.refreshToken,
    this.refreshTokenExpireAt,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return _$LoginResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}
