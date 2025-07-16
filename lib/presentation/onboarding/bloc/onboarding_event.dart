import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_event.freezed.dart';

@freezed
abstract class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.addGulaDarahPuasa({
    required String gulaDarahPuasa,
  }) = AddGulaDarahPuasaEvent;

  const factory OnboardingEvent.addGulaDarahSewaktu({
    required String gulaDarahSewaktu,
  }) = AddGulaDarahSewaktuEvent;

  const factory OnboardingEvent.getGulaDarah() = GetGulaDarahEvent;

  const factory OnboardingEvent.checkGulaDarahPuasa({
    required String gulaDarahPuasa,
  }) = CheckGulaDarahPuasaEvent;

  const factory OnboardingEvent.checkGulaDarahSewaktu({
    required String gulaDarahSewaktu,
  }) = CheckGulaDarahSewaktuEvent;
}
