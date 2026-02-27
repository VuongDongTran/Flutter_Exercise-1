import 'package:freezed_annotation/freezed_annotation.dart';
import '../../base/bloc/base_cubit.dart';

part 'loading_state.dart';
part 'loading_cubit.freezed.dart';

class LoadingCubit extends BaseCubit<LoadingState> {
  LoadingCubit() : super(const LoadingState.initial());
  void loadingPage() {
    loadingSink.add(true);
    emit(const LoadingState.loading());
  }
}
