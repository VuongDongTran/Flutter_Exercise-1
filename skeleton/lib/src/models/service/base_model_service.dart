import 'package:json_annotation/json_annotation.dart';
part 'base_model_service.g.dart';

@JsonSerializable()
class BaseModelService {
  int? statusCode;
  String? message;
  bool? success;
  List<Error>? errors;

  BaseModelService({
    this.statusCode,
    this.message,
    this.success,
    this.errors,
  });

  factory BaseModelService.fromJson(Map<String, dynamic> json) =>
      _$BaseModelServiceFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelServiceToJson(this);
}

@JsonSerializable()
class Error {
  String errorCode;
  String errorMessage;
  String propertyName;

  Error({
    required this.errorCode,
    required this.errorMessage,
    required this.propertyName,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        errorCode: json['errorCode'],
        errorMessage: json['errorMessage'],
        propertyName: json['propertyName'],
      );

  Map<String, dynamic> toJson() => {
        'errorCode': errorCode,
        'errorMessage': errorMessage,
        'propertyName': propertyName,
      };
}
