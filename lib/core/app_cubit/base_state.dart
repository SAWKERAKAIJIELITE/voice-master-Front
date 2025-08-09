import 'package:freezed_annotation/freezed_annotation.dart';
import '../core_models/failure.dart';

part 'base_state.freezed.dart';

@freezed
class BaseState<T> with _$BaseState {
  const factory BaseState.initial() = Initial;

  const factory BaseState.loading() = Loading;

  const factory BaseState.loaded(T? data) = Loaded;

  const factory BaseState.error(Failure error) = Error;
}
