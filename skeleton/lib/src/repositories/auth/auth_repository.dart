import '../../base/restful/base_response.dart';
import '../../base/restful/data_result.dart';
import '../../models/service/auth/login_model_service.dart';
import '../../models/service/auth/login_model_service_response.dart';

/// Repository interface for authentication operations
/// Separates business logic from service/API calls
abstract class AuthRepository {
  /// Login with credentials
  /// Returns authentication token and user info on success
  Future<DataResult<DataResponse<LoginModelServiceResponse>>> login(
    LoginModelService loginRequest,
  );

  /// Logout from the application
  /// Clears authentication data and navigates to login screen
  Future<void> logout();
}
