import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/activity/activity_entity.dart';
import '../../repository/assesment_repository.dart';

class AddActivityUseCase
    extends UseCase<List<ActivityEntity>, AddParams<ActivityEntity>> {
  final AssesmentRepository assesmentRepo;
  const AddActivityUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<ActivityEntity>>> call(
    AddParams<ActivityEntity> params,
  ) async {
    return await assesmentRepo.addActivity(params);
  }
}
