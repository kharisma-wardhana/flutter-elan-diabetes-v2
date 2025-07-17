import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state.freezed.dart';

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState.initial() = OnboardingInitial;
  const factory OnboardingState.loading() = OnboardingLoading;
  const factory OnboardingState.success() = OnboardingSuccess;
  const factory OnboardingState.successNormal() = OnboardingSuccessNormal;
  const factory OnboardingState.successDiabetes(int type) =
      OnboardingSuccessDiabetes;
  const factory OnboardingState.error(String message) = OnboardingError;
}
