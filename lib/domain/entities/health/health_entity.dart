import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_entity.freezed.dart';
part 'health_entity.g.dart';

@freezed
abstract class HealthEntity with _$HealthEntity {
  const factory HealthEntity({
    required int steps,
    required int heartRate,
    required String bloodPressure,
  }) = _HealthEntity;

  factory HealthEntity.fromJson(Map<String, dynamic> json) =>
      _$HealthEntityFromJson(json);
}
