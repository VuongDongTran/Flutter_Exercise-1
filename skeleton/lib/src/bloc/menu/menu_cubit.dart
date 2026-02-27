import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_state.dart';
part 'menu_cubit.freezed.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(const MenuState.selected(index: 0));

  void onChangeIndex(@Default(0) int index) {
    emit(MenuState.selecting(index: index));
    emit(MenuState.selected(index: index));
  }
}
