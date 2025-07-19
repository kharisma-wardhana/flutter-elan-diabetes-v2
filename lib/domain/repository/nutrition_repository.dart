import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../../core/usecase.dart';
import '../entities/nutrition_entity.dart';

abstract class NutritionRepository {
  const NutritionRepository();

  Future<Either<Failure, List<NutritionEntity>>> getAllNutrition(
    SearchParams params,
  );
  Future<Either<Failure, List<NutritionEntity>>> addNutrition(
    AddParams<NutritionEntity> params,
  );
}
