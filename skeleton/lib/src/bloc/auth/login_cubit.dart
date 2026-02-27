import 'dart:async';
import 'dart:developer' as developer;

import '../../base/bloc/base_cubit.dart';
import '../../common/constants.dart';
import '../../models/service/auth/login_model_service.dart';
import '../../preferences/user_preference.dart';
import '../../repositories/auth/auth_repository.dart';
import 'login_state.dart';

/// BLoC for authentication/login logic
/// Manages login state and user authentication flow
class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit(this._authRepository, this._preference)
      : super(const LoginState.initial());

  final AuthRepository _authRepository;
  final UserPreference _preference;

  /// Perform login with username and password
  /// - username: User's username/email
  /// - password: User's password
  /// - isSavePassword: Whether to save credentials locally
  Future<void> onLogin(
    String username,
    String password,
    bool isSavePassword,
  ) async {
    try {
      // Show loading indicator
      loadingSink.add(true);
      emit(const LoginState.loading());

      // Create login request
      // TODO: Replace hardcoded device ID with actual device identifier
      final loginRequest = LoginModelService(
        username.trim(),
        password.trim(),
        'ed8e4910-45bd-438e-8724-e6a685a36a37', // Device/Client ID
        null,
      );

      // Call login API through repository
      final result = await _authRepository.login(loginRequest);

      if (result.isSuccess) {
        // Save authentication tokens and user data
        await _preference.setValue(
          UserSharedPreferencesPath.username,
          username,
        );
        await _preference.setValue(
          UserSharedPreferencesPath.token,
          result.data!.dataResponse.result!.accessToken,
        );
        await _preference.setValue(
          UserSharedPreferencesPath.refreshToken,
          result.data!.dataResponse.result!.refreshToken,
        );
        await _preference.setValue(
          UserSharedPreferencesPath.hasLogin,
          isSavePassword,
        );
        await _preference.setValue(
          UserSharedPreferencesPath.tokenExpireAt,
          result.data!.dataResponse.result!.accessTokenExpireAt,
        );

        // Emit success state
        emit(const LoginState.success());
      } else {
        // Handle API error
        final errorMessage = result.error?.message ?? 'Unknown error';
        emit(LoginState.error(message: errorMessage));
        errorSink.add(errorMessage);
      }
    } catch (e, stackTrace) {
      // Handle unexpected exceptions
      developer.log(
        'Login error',
        error: e,
        stackTrace: stackTrace,
      );

      final errorMessage = _getErrorMessage(e);
      emit(LoginState.error(message: errorMessage));
      errorSink.add(errorMessage);
    } finally {
      // Always hide loading indicator
      loadingSink.add(false);
    }
  }

  /// Parse exception to user-friendly error message
  String _getErrorMessage(dynamic exception) {
    if (exception is Exception) {
      return exception.toString();
    }
    return 'An unexpected error occurred';
  }
}
