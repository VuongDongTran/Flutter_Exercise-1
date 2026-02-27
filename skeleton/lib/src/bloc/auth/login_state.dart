import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;

  const factory LoginState.success() = LoginSuccess;

  const factory LoginState.loading() = LoginLoading;

  const factory LoginState.error({@Default('') String message}) = _Error;

  const factory LoginState.userForceChangePassword(bool value) =
      UserForceChangePassword;
}
