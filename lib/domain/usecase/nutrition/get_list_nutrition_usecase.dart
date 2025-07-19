import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/nutrition_entity.dart';
import '../../repository/nutrition_repository.dart';

class GetListNutritionUsecase
    extends UseCase<List<NutritionEntity>, SearchParams> {
  final NutritionRepository nutritionRepo;

  GetListNutritionUsecase({required this.nutritionRepo});

  @override
  Future<Either<Failure, List<NutritionEntity>>> call(
    SearchParams params,
  ) async {
    return await nutritionRepo.getAllNutrition(params);
  }
}
