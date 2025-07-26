import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/assesment/assesment_entity.dart';
import '../../repository/assesment_repository.dart';

class GetAssesmentUsecase extends UseCase<AssesmentEntity, NoParams> {
  final AssesmentRepository assesmentRepository;

  GetAssesmentUsecase({required this.assesmentRepository});

  @override
  Future<Either<Failure, AssesmentEntity>> call(NoParams params) async {
    return await assesmentRepository.getAssesment();
  }
}
