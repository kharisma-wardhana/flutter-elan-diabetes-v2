import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constant.dart';
import '../../core/error.dart';
import '../../core/usecase.dart';
import '../../domain/entities/nutrition_entity.dart';
import '../../domain/repository/nutrition_repository.dart';
import '../datasource/remote/nutrition_remote_datasource.dart';

class NutritionRepositoryImpl implements NutritionRepository {
  final NutritionRemoteDatasource nutritionRemoteDatasource;
  final FlutterSecureStorage secureStorage;

  NutritionRepositoryImpl({
    required this.nutritionRemoteDatasource,
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
  Future<Either<Failure, List<NutritionEntity>>> addNutrition(
    AddParams<NutritionEntity> params,
  ) async {
    try {
      final userID = await getUserID();
      final nutritions = await nutritionRemoteDatasource.addNutrition(
        userID,
        params.data,
      );
      return Right(nutritions.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<NutritionEntity>>> getAllNutrition(
    SearchParams params,
  ) async {
    try {
      final userID = await getUserID();
      final nutritions = await nutritionRemoteDatasource.getAllNutrition(
        userID,
        params.date,
      );
      return Right(nutritions.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
