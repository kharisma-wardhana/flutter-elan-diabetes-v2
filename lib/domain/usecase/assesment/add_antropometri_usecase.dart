import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/antropometri_entity.dart';
import '../../repository/assesment_repository.dart';

class AddAntropometriUseCase
    extends UseCase<AntropometriEntity, AddParams<AntropometriEntity>> {
  final AssesmentRepository assesmentRepo;
  const AddAntropometriUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, AntropometriEntity>> call(
    AddParams<AntropometriEntity> params,
  ) async {
    return await assesmentRepo.addAntropometri(params);
  }
}
