part of 'loading_cubit.dart';

@freezed
class LoadingState with _$LoadingState {
  const factory LoadingState.initial() = _Initial;
  const factory LoadingState.loading() = _LoadingState;
}
