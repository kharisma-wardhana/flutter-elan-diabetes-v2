import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/asam_urat_entity.dart';
import '../../repository/assesment_repository.dart';

class GetListAsamUratUsecase
    extends UseCase<List<AsamUratEntity>, SearchParams> {
  final AssesmentRepository assesmentRepo;
  const GetListAsamUratUsecase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<AsamUratEntity>>> call(
    SearchParams params,
  ) async {
    return await assesmentRepo.getListAsamUrat(params);
  }
}
