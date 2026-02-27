// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState()';
}


}

/// @nodoc
class $LoginStateCopyWith<$Res>  {
$LoginStateCopyWith(LoginState _, $Res Function(LoginState) __);
}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoginInitial value)?  initial,TResult Function( LoginSuccess value)?  success,TResult Function( LoginLoading value)?  loading,TResult Function( _Error value)?  error,TResult Function( UserForceChangePassword value)?  userForceChangePassword,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoginInitial() when initial != null:
return initial(_that);case LoginSuccess() when success != null:
return success(_that);case LoginLoading() when loading != null:
return loading(_that);case _Error() when error != null:
return error(_that);case UserForceChangePassword() when userForceChangePassword != null:
return userForceChangePassword(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoginInitial value)  initial,required TResult Function( LoginSuccess value)  success,required TResult Function( LoginLoading value)  loading,required TResult Function( _Error value)  error,required TResult Function( UserForceChangePassword value)  userForceChangePassword,}){
final _that = this;
switch (_that) {
case LoginInitial():
return initial(_that);case LoginSuccess():
return success(_that);case LoginLoading():
return loading(_that);case _Error():
return error(_that);case UserForceChangePassword():
return userForceChangePassword(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoginInitial value)?  initial,TResult? Function( LoginSuccess value)?  success,TResult? Function( LoginLoading value)?  loading,TResult? Function( _Error value)?  error,TResult? Function( UserForceChangePassword value)?  userForceChangePassword,}){
final _that = this;
switch (_that) {
case LoginInitial() when initial != null:
return initial(_that);case LoginSuccess() when success != null:
return success(_that);case LoginLoading() when loading != null:
return loading(_that);case _Error() when error != null:
return error(_that);case UserForceChangePassword() when userForceChangePassword != null:
return userForceChangePassword(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  success,TResult Function()?  loading,TResult Function( String message)?  error,TResult Function( bool value)?  userForceChangePassword,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoginInitial() when initial != null:
return initial();case LoginSuccess() when success != null:
return success();case LoginLoading() when loading != null:
return loading();case _Error() when error != null:
return error(_that.message);case UserForceChangePassword() when userForceChangePassword != null:
return userForceChangePassword(_that.value);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  success,required TResult Function()  loading,required TResult Function( String message)  error,required TResult Function( bool value)  userForceChangePassword,}) {final _that = this;
switch (_that) {
case LoginInitial():
return initial();case LoginSuccess():
return success();case LoginLoading():
return loading();case _Error():
return error(_that.message);case UserForceChangePassword():
return userForceChangePassword(_that.value);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  success,TResult? Function()?  loading,TResult? Function( String message)?  error,TResult? Function( bool value)?  userForceChangePassword,}) {final _that = this;
switch (_that) {
case LoginInitial() when initial != null:
return initial();case LoginSuccess() when success != null:
return success();case LoginLoading() when loading != null:
return loading();case _Error() when error != null:
return error(_that.message);case UserForceChangePassword() when userForceChangePassword != null:
return userForceChangePassword(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class LoginInitial implements LoginState {
  const LoginInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.initial()';
}


}




/// @nodoc


class LoginSuccess implements LoginState {
  const LoginSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.success()';
}


}




/// @nodoc


class LoginLoading implements LoginState {
  const LoginLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.loading()';
}


}




/// @nodoc


class _Error implements LoginState {
  const _Error({this.message = ''});
  

@JsonKey() final  String message;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'LoginState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UserForceChangePassword implements LoginState {
  const UserForceChangePassword(this.value);
  

 final  bool value;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserForceChangePasswordCopyWith<UserForceChangePassword> get copyWith => _$UserForceChangePasswordCopyWithImpl<UserForceChangePassword>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserForceChangePassword&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'LoginState.userForceChangePassword(value: $value)';
}


}

/// @nodoc
abstract mixin class $UserForceChangePasswordCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory $UserForceChangePasswordCopyWith(UserForceChangePassword value, $Res Function(UserForceChangePassword) _then) = _$UserForceChangePasswordCopyWithImpl;
@useResult
$Res call({
 bool value
});




}
/// @nodoc
class _$UserForceChangePasswordCopyWithImpl<$Res>
    implements $UserForceChangePasswordCopyWith<$Res> {
  _$UserForceChangePasswordCopyWithImpl(this._self, this._then);

  final UserForceChangePassword _self;
  final $Res Function(UserForceChangePassword) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(UserForceChangePassword(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
