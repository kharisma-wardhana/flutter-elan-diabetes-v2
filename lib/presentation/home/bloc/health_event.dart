import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_event.freezed.dart';

@freezed
abstract class HealthEvent with _$HealthEvent {
  const factory HealthEvent.fetchHealthData() = FetchHealthDataEvent;

  const factory HealthEvent.requestPermissions() = RequestPermissions;

  const factory HealthEvent.getHealthData({
    required DateTime startDate,
    required DateTime endDate,
  }) = GetHealthData;

  const factory HealthEvent.checkPermissions() = CheckPermissions;
}
