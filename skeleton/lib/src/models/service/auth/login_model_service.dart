import 'package:json_annotation/json_annotation.dart';

import '../../../base/restful/base_request.dart';
part 'login_model_service.g.dart';

@JsonSerializable()
class LoginModelService extends BaseRequestModel {
  final String? appId;
  final String? grantType;
  final String username;
  final String password;
  LoginModelService(
    this.username,
    this.password,
    this.appId ,
    this.grantType,
      );

  @override
  Map<String, dynamic> toJson() => _$LoginModelServiceToJson(this);
}
