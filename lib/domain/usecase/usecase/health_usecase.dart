import 'package:dartz/dartz.dart';
import 'package:health/health.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/health/health_entity.dart';

class HealthUsecase implements UseCase<HealthEntity, List<HealthDataType>> {
  final Health _health;

  const HealthUsecase(this._health);

  @override
  Future<Either<Failure, HealthEntity>> call(
    List<HealthDataType> params,
  ) async {
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 1));

    List<HealthDataPoint> data = await _health.getHealthDataFromTypes(
      types: params,
      startTime: yesterday,
      endTime: now,
    );

    num steps = 0;
    num? heartRate;
    num? systolic;
    num? diastolic;

    for (var point in data) {
      switch (point.type) {
        case HealthDataType.STEPS:
          steps += point.value.toJson()['numericValue'] ?? 0;
          break;
        case HealthDataType.HEART_RATE:
          heartRate ??= point.value.toJson()["numericValue"] ?? 0;
          break;
        case HealthDataType.BLOOD_PRESSURE_SYSTOLIC:
          systolic ??= point.value.toJson()["numericValue"] ?? 0;
          break;
        case HealthDataType.BLOOD_PRESSURE_DIASTOLIC:
          diastolic ??= point.value.toJson()["numericValue"] ?? 0;
          break;
        default:
          break;
      }
    }

    if (steps == 0 &&
        heartRate == null &&
        systolic == null &&
        diastolic == null) {
      return Left(NotFoundFailure("Tidak ada data kesehatan yang ditemukan."));
    }

    return Right(
      HealthEntity(
        steps: steps.toInt(),
        heartRate: heartRate?.toInt() ?? 0,
        bloodPressure: systolic != null && diastolic != null
            ? "$systolic/$diastolic"
            : "-",
      ),
    );
  }
}
