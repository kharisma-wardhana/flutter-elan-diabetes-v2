import 'package:bloc/bloc.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../domain/health/usecase/authorization_usecase.dart';
import '../../../domain/health/usecase/health_usecase.dart';

import 'health_event.dart';
import 'health_state.dart';

class HealthBloc extends Bloc<HealthEvent, HealthState> {
  final AuthorizationUsecase authorizationUsecase;
  final HealthUsecase healthUsecase;

  HealthBloc({required this.authorizationUsecase, required this.healthUsecase})
    : super(HealthState.initial()) {
    on<FetchHealthDataEvent>((event, emit) async {
      emit(HealthState.loading());
      final types = [
        HealthDataType.STEPS,
        HealthDataType.HEART_RATE,
        HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
        HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      ];

      await authorizationUsecase.call(types);

      final data = await healthUsecase.call(types);
      data.fold(
        (failure) => emit(HealthState.error(failure.message)),
        (healthData) => emit(HealthState.success(healthData)),
      );
    });

    on<RequestPermissions>((event, emit) async {
      emit(HealthState.checkPermissions());
      // Request permissions for activity recognition and sensors
      final activityPermission = await Permission.activityRecognition.request();
      final sensorsPermission = await Permission.sensors.request();
      if (activityPermission.isGranted && sensorsPermission.isGranted) {
        emit(HealthState.permissionsGranted());
      } else {
        emit(HealthState.permissionsDenied());
      }
      add(FetchHealthDataEvent());
    });
  }
}
