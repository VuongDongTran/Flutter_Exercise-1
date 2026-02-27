// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModelService _$LoginModelServiceFromJson(Map<String, dynamic> json) =>
    LoginModelService(
      json['username'] as String,
      json['password'] as String,
      json['appId'] as String?,
      json['grantType'] as String?,
    );

Map<String, dynamic> _$LoginModelServiceToJson(LoginModelService instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'grantType': instance.grantType,
      'username': instance.username,
      'password': instance.password,
    };
