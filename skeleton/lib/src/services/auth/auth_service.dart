
import '../../base/restful/base_response.dart';
import '../../base/restful/data_result.dart';
import '../../base/restful/rest_utility.dart';
import '../../base/services/base_service.dart';
import '../../common/constants.dart';
import '../../models/service/auth/login_model_service.dart';
import '../../models/service/auth/login_model_service_response.dart';

/// Abstract interface for authentication API calls
/// Only handles API operations, not business logic
abstract class Authentication extends BaseService {
  Authentication(super.restUtils);

  /// Call login API endpoint
  /// Returns authentication token and user data on success
  Future<DataResult<DataResponse<LoginModelServiceResponse>>> login(
    LoginModelService loginModelService,
  );
}

/// Implementation of Authentication service
/// Handles all authentication API calls
class AuthService extends Authentication {
  AuthService(super.restUtils);

  @override
  Future<DataResult<DataResponse<LoginModelServiceResponse>>> login(
    LoginModelService loginModelService,
  ) {
    return rest.request<LoginModelServiceResponse>(
      Method.post,
      ApiPath.login,
      data: loginModelService,
      factory: () => LoginModelServiceResponse(),
    );
  }
}
