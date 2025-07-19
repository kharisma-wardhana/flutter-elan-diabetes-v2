import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/tensi_entity.dart';
import '../../repository/assesment_repository.dart';

class AddBloodPressureUseCase
    extends UseCase<List<TensiEntity>, AddParams<TensiEntity>> {
  final AssesmentRepository assesmentRepo;
  const AddBloodPressureUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<TensiEntity>>> call(
    AddParams<TensiEntity> params,
  ) async {
    return await assesmentRepo.addTekananDarah(params);
  }
}
