import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/water_entity.dart';
import '../../repository/assesment_repository.dart';

class GetListWaterUseCase extends UseCase<List<WaterEntity>, SearchParams> {
  final AssesmentRepository assesmentRepo;
  const GetListWaterUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<WaterEntity>>> call(SearchParams params) async {
    return await assesmentRepo.getListWater(params);
  }
}
