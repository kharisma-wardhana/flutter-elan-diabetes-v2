import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/nutrition_entity.dart';
import '../../repository/nutrition_repository.dart';

class AddNutritionUseCase
    extends UseCase<List<NutritionEntity>, AddParams<NutritionEntity>> {
  final NutritionRepository nutritionRepo;
  const AddNutritionUseCase({required this.nutritionRepo});

  @override
  Future<Either<Failure, List<NutritionEntity>>> call(
    AddParams<NutritionEntity> params,
  ) async {
    return await nutritionRepo.addNutrition(params);
  }
}
