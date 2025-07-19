import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constant.dart';
import '../../core/error.dart';
import '../../core/usecase.dart';
import '../../domain/entities/medicine_entity.dart';
import '../../domain/repository/medicine_repository.dart';
import '../datasource/remote/medicine_remote_datasource.dart';

class MedicineRepositoryImpl implements MedicineRepository {
  final MedicineRemoteDatasource medicineRemoteDatasource;
  final FlutterSecureStorage secureStorage;

  MedicineRepositoryImpl({
    required this.medicineRemoteDatasource,
    required this.secureStorage,
  });

  Future<int> getUserID() async {
    final userID = await secureStorage.read(key: userIDKey);
    if (userID == null) {
      throw InvalidInputFailure("userID null");
    }
    return int.parse(userID);
  }

  @override
  Future<Either<Failure, List<MedicineEntity>>> addMedicine(
    AddParams<MedicineEntity> params,
  ) async {
    try {
      final userID = await getUserID();
      final medicines = await medicineRemoteDatasource.addMedicine(
        userID,
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
      final userID = await getUserID();
      final medicines = await medicineRemoteDatasource.getAllMedicine(
        userID,
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
