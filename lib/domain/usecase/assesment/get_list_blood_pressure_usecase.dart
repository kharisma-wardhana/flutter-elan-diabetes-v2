import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/tensi_entity.dart';
import '../../repository/assesment_repository.dart';

class GetListBloodPressureUseCase
    extends UseCase<List<TensiEntity>, SearchParams> {
  final AssesmentRepository assesmentRepo;
  const GetListBloodPressureUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<TensiEntity>>> call(SearchParams params) async {
    return await assesmentRepo.getListTekananDarah(params);
  }
}
