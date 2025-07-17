import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_event.freezed.dart';

@freezed
abstract class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.addGulaDarah({
    required String gulaDarahPuasa,
    required String gulaDarahSewaktu,
  }) = AddGulaDarahEvent;

  const factory OnboardingEvent.addActivity({required String activityName}) =
      AddActivityEvent;
}
