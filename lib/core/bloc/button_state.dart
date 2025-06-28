import 'package:freezed_annotation/freezed_annotation.dart';

part 'button_state.freezed.dart';

@freezed
class ButtonState with _$ButtonState {
  const factory ButtonState.initial() = ButtonInitial;
  const factory ButtonState.loading() = ButtonLoading;
  const factory ButtonState.success() = ButtonSuccess;
  const factory ButtonState.error({required String message}) = ButtonError;
}
