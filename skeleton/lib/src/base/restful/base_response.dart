import '../../models/service/base_model_service.dart';

class DataResponse<T extends BaseResponseModel<dynamic>>
    extends BaseModelService {
  late T dataResponse;

  DataResponse(this.dataResponse);

  DataResponse.fromJson(Map<String, dynamic> json, T Function() factory) {
    final response = factory();
    final baseMode = BaseModelService.fromJson(json);
    statusCode = baseMode.statusCode;
    errors = baseMode.errors;
    success = baseMode.success;
    message = baseMode.message;
    dataResponse = response.fromJson(json);
  }
}

abstract class BaseResponseModel<T> {
  T fromJson(Map<String, dynamic> json);
}
