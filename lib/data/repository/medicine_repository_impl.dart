import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../../core/usecase.dart';
import '../../domain/entities/medicine_entity.dart';
import '../../domain/repository/medicine_repository.dart';
import '../datasource/remote/medicine_remote_datasource.dart';

class MedicineRepositoryImpl implements MedicineRepository {
  final MedicineRemoteDatasource medicineRemoteDatasource;

  MedicineRepositoryImpl({required this.medicineRemoteDatasource});

  @override
  Future<Either<Failure, List<MedicineEntity>>> addMedicine(
    AddParams<MedicineEntity> params,
  ) async {
    try {
      final medicines = await medicineRemoteDatasource.addMedicine(
        params.userId,
        params.data,
      );
      return Right(medicines.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<MedicineEntity>>> getAllMedicine(
    SearchParams params,
  ) async {
    try {
      final medicines = await medicineRemoteDatasource.getAllMedicine(
        params.userId,
        params.date,
      );
      return Right(medicines.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<MedicineEntity>>> updateStatusMedicine(
    UpdateParams<int> params,
  ) async {
    try {
      final medicines = await medicineRemoteDatasource.updateStatusMedicine(
        params.userId,
        params.dataId,
        params.data,
      );
      return Right(medicines.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
