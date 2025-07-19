import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/asam_urat_entity.dart';
import '../../repository/assesment_repository.dart';

class AddAsamUratUsecase
    extends UseCase<List<AsamUratEntity>, AddParams<AsamUratEntity>> {
  final AssesmentRepository assesmentRepo;
  const AddAsamUratUsecase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<AsamUratEntity>>> call(
    AddParams<AsamUratEntity> params,
  ) async {
    return await assesmentRepo.addAsamUrat(params);
  }
}
