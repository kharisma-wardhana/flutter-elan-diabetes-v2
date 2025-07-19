import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
abstract class AuthEvent with _$AuthEvent {
  const factory AuthEvent.register({
    required String name,
    required String email,
    required String mobile,
    required String dob,
    required String gender,
  }) = RegisterEvent;

  const factory AuthEvent.login({
    required String username,
    required String password,
  }) = LoginEvent;

  const factory AuthEvent.logout() = LogoutEvent;

  const factory AuthEvent.appStarted() = AppStarted;

  const factory AuthEvent.completeOnboarding() = CompleteOnboardingEvent;

  const factory AuthEvent.completeAntropometri() = CompleteAntropometriEvent;
}
