// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModelService _$BaseModelServiceFromJson(Map<String, dynamic> json) =>
    BaseModelService(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      success: json['success'] as bool?,
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => Error.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BaseModelServiceToJson(BaseModelService instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'success': instance.success,
      'errors': instance.errors,
    };

Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
  errorCode: json['errorCode'] as String,
  errorMessage: json['errorMessage'] as String,
  propertyName: json['propertyName'] as String,
);

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
  'errorCode': instance.errorCode,
  'errorMessage': instance.errorMessage,
  'propertyName': instance.propertyName,
};
