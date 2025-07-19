import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../../core/usecase.dart';
import '../../domain/entities/nutrition_entity.dart';
import '../../domain/repository/nutrition_repository.dart';
import '../datasource/remote/nutrition_remote_datasource.dart';

class NutritionRepositoryImpl implements NutritionRepository {
  final NutritionRemoteDatasource nutritionRemoteDatasource;

  NutritionRepositoryImpl({required this.nutritionRemoteDatasource});

  @override
  Future<Either<Failure, List<NutritionEntity>>> addNutrition(
    AddParams<NutritionEntity> params,
  ) async {
    try {
      final nutritions = await nutritionRemoteDatasource.addNutrition(
        params.userId,
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
      final nutritions = await nutritionRemoteDatasource.getAllNutrition(
        params.userId,
        params.date,
      );
      return Right(nutritions.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
