// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model_service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModelServiceResponse _$LoginModelServiceResponseFromJson(
  Map<String, dynamic> json,
) => LoginModelServiceResponse(
  result: json['result'] == null
      ? null
      : LoginResult.fromJson(json['result'] as Map<String, dynamic>),
  statusCode: (json['statusCode'] as num?)?.toInt(),
  message: json['message'] as String?,
  success: json['success'] as bool?,
  errors: json['errors'],
);

Map<String, dynamic> _$LoginModelServiceResponseToJson(
  LoginModelServiceResponse instance,
) => <String, dynamic>{
  'result': instance.result,
  'statusCode': instance.statusCode,
  'message': instance.message,
  'success': instance.success,
  'errors': instance.errors,
};

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) => LoginResult(
  accessToken: json['accessToken'] as String?,
  accessTokenExpireAt: json['accessTokenExpireAt'] == null
      ? null
      : DateTime.parse(json['accessTokenExpireAt'] as String),
  refreshToken: json['refreshToken'] as String?,
  refreshTokenExpireAt: json['refreshTokenExpireAt'] == null
      ? null
      : DateTime.parse(json['refreshTokenExpireAt'] as String),
);

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'accessTokenExpireAt': instance.accessTokenExpireAt?.toIso8601String(),
      'refreshToken': instance.refreshToken,
      'refreshTokenExpireAt': instance.refreshTokenExpireAt?.toIso8601String(),
    };
