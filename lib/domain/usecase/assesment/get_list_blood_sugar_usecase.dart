import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/gula_darah/gula_darah.dart';
import '../../repository/assesment_repository.dart';

class GetListBloodSugarUseCase
    extends UseCase<List<GulaDarahEntity>, SearchParams> {
  final AssesmentRepository assesmentRepo;

  const GetListBloodSugarUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<GulaDarahEntity>>> call(
    SearchParams params,
  ) async {
    return await assesmentRepo.getListGulaDarah(params);
  }
}
