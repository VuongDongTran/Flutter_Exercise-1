// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MenuState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MenuState()';
}


}

/// @nodoc
class $MenuStateCopyWith<$Res>  {
$MenuStateCopyWith(MenuState _, $Res Function(MenuState) __);
}


/// Adds pattern-matching-related methods to [MenuState].
extension MenuStatePatterns on MenuState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MenuInitial value)?  initial,TResult Function( MenuSelectingState value)?  selecting,TResult Function( MenuSelectedState value)?  selected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MenuInitial() when initial != null:
return initial(_that);case MenuSelectingState() when selecting != null:
return selecting(_that);case MenuSelectedState() when selected != null:
return selected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MenuInitial value)  initial,required TResult Function( MenuSelectingState value)  selecting,required TResult Function( MenuSelectedState value)  selected,}){
final _that = this;
switch (_that) {
case MenuInitial():
return initial(_that);case MenuSelectingState():
return selecting(_that);case MenuSelectedState():
return selected(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MenuInitial value)?  initial,TResult? Function( MenuSelectingState value)?  selecting,TResult? Function( MenuSelectedState value)?  selected,}){
final _that = this;
switch (_that) {
case MenuInitial() when initial != null:
return initial(_that);case MenuSelectingState() when selecting != null:
return selecting(_that);case MenuSelectedState() when selected != null:
return selected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( int index)?  selecting,TResult Function( int index)?  selected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MenuInitial() when initial != null:
return initial();case MenuSelectingState() when selecting != null:
return selecting(_that.index);case MenuSelectedState() when selected != null:
return selected(_that.index);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( int index)  selecting,required TResult Function( int index)  selected,}) {final _that = this;
switch (_that) {
case MenuInitial():
return initial();case MenuSelectingState():
return selecting(_that.index);case MenuSelectedState():
return selected(_that.index);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( int index)?  selecting,TResult? Function( int index)?  selected,}) {final _that = this;
switch (_that) {
case MenuInitial() when initial != null:
return initial();case MenuSelectingState() when selecting != null:
return selecting(_that.index);case MenuSelectedState() when selected != null:
return selected(_that.index);case _:
  return null;

}
}

}

/// @nodoc


class MenuInitial implements MenuState {
  const MenuInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MenuState.initial()';
}


}




/// @nodoc


class MenuSelectingState implements MenuState {
  const MenuSelectingState({this.index = 0});
  

@JsonKey() final  int index;

/// Create a copy of MenuState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuSelectingStateCopyWith<MenuSelectingState> get copyWith => _$MenuSelectingStateCopyWithImpl<MenuSelectingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuSelectingState&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'MenuState.selecting(index: $index)';
}


}

/// @nodoc
abstract mixin class $MenuSelectingStateCopyWith<$Res> implements $MenuStateCopyWith<$Res> {
  factory $MenuSelectingStateCopyWith(MenuSelectingState value, $Res Function(MenuSelectingState) _then) = _$MenuSelectingStateCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$MenuSelectingStateCopyWithImpl<$Res>
    implements $MenuSelectingStateCopyWith<$Res> {
  _$MenuSelectingStateCopyWithImpl(this._self, this._then);

  final MenuSelectingState _self;
  final $Res Function(MenuSelectingState) _then;

/// Create a copy of MenuState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(MenuSelectingState(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class MenuSelectedState implements MenuState {
  const MenuSelectedState({this.index = 0});
  

@JsonKey() final  int index;

/// Create a copy of MenuState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MenuSelectedStateCopyWith<MenuSelectedState> get copyWith => _$MenuSelectedStateCopyWithImpl<MenuSelectedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MenuSelectedState&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'MenuState.selected(index: $index)';
}


}

/// @nodoc
abstract mixin class $MenuSelectedStateCopyWith<$Res> implements $MenuStateCopyWith<$Res> {
  factory $MenuSelectedStateCopyWith(MenuSelectedState value, $Res Function(MenuSelectedState) _then) = _$MenuSelectedStateCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$MenuSelectedStateCopyWithImpl<$Res>
    implements $MenuSelectedStateCopyWith<$Res> {
  _$MenuSelectedStateCopyWithImpl(this._self, this._then);

  final MenuSelectedState _self;
  final $Res Function(MenuSelectedState) _then;

/// Create a copy of MenuState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(MenuSelectedState(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
