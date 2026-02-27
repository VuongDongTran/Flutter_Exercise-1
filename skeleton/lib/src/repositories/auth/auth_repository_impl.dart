import '../../base/restful/base_response.dart';
import '../../base/restful/data_result.dart';
import '../../base/utils/global_key.dart';
import '../../models/service/auth/login_model_service.dart';
import '../../models/service/auth/login_model_service_response.dart';
import '../../preferences/user_preference.dart';
import '../../routers/route_key.dart';
import '../../services/auth/auth_service.dart';
import 'auth_repository.dart';

/// Implementation of AuthRepository
/// Handles authentication business logic, data persistence, and navigation
class AuthRepositoryImpl implements AuthRepository {
  final Authentication _authService;
  final UserPreference _userPreference;

  AuthRepositoryImpl(this._authService, this._userPreference);

  @override
  Future<DataResult<DataResponse<LoginModelServiceResponse>>> login(
    LoginModelService loginRequest,
  ) async {
    return _authService.login(loginRequest);
  }

  @override
  Future<void> logout() async {
    // Clear authentication data from preferences
    await _userPreference.clearAll();

    // Navigate to login screen
    await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      RouteKey.login,
      (route) => false,
    );
  }
}
