import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/antropometri_entity.dart';
import '../../repository/assesment_repository.dart';

class GetDetailAntropometriUsecase extends UseCase<AntropometriEntity?, int> {
  final AssesmentRepository assesmentRepo;

  const GetDetailAntropometriUsecase({required this.assesmentRepo});

  @override
  Future<Either<Failure, AntropometriEntity?>> call(int params) async {
    return await assesmentRepo.getDetailAntropometri(params);
  }
}
