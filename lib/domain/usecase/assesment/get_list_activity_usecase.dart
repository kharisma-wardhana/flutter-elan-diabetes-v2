import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../core/usecase.dart';
import '../../entities/activity/activity_entity.dart';
import '../../repository/assesment_repository.dart';

class GetListActivityUseCase
    extends UseCase<List<ActivityEntity>, SearchParams> {
  final AssesmentRepository assesmentRepo;
  const GetListActivityUseCase({required this.assesmentRepo});

  @override
  Future<Either<Failure, List<ActivityEntity>>> call(
    SearchParams params,
  ) async {
    return await assesmentRepo.getListActivity(params);
  }
}
