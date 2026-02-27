part of 'menu_cubit.dart';

@freezed
class MenuState with _$MenuState {
  const factory MenuState.initial() = MenuInitial;
  const factory MenuState.selecting({@Default(0) int index}) =
      MenuSelectingState;
  const factory MenuState.selected({@Default(0) int index}) = MenuSelectedState;
}
