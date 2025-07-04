import 'package:freezed_annotation/freezed_annotation.dart';

part 'gula_state.freezed.dart';

@freezed
abstract class GulaState with _$GulaState {
  const factory GulaState.initial() = GulaInitial;
  const factory GulaState.loading() = GulaLoading;
  const factory GulaState.success() = GulaSuccess;
  const factory GulaState.error(String message) = GulaError;
}
