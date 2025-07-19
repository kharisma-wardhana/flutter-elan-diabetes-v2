import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/health/health_entity.dart';

part 'health_state.freezed.dart';

@freezed
abstract class HealthState with _$HealthState {
  const factory HealthState.initial() = HealthInitial;

  const factory HealthState.loading() = HealthLoading;

  const factory HealthState.permissionsGranted() = HealthPermissionsGranted;

  const factory HealthState.permissionsDenied() = HealthPermissionsDenied;

  const factory HealthState.checkPermissions() = HealthCheckPermissions;

  const factory HealthState.success(HealthEntity health) = HealthSuccess;

  const factory HealthState.error(String message) = HealthError;
}
