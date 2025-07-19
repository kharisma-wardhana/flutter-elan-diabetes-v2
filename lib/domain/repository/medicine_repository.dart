import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../../core/usecase.dart';
import '../entities/medicine_entity.dart';

abstract class MedicineRepository {
  const MedicineRepository();

  Future<Either<Failure, List<MedicineEntity>>> getAllMedicine(
    SearchParams params,
  );
  Future<Either<Failure, List<MedicineEntity>>> addMedicine(
    AddParams<MedicineEntity> params,
  );

  Future<Either<Failure, List<MedicineEntity>>> updateStatusMedicine(
    UpdateParams<int> params,
  );
}
