import 'package:dartz/dartz.dart';

import 'package:elan/core/error.dart';

import '../../../core/usecase.dart';
import '../entity/activity_entity.dart';
import '../repository/activity_repo.dart';

class AddActivityUsecase
    implements UseCase<ActivityEntity, Map<String, String>> {
  final ActivityRepo activityRepo;
  AddActivityUsecase({required this.activityRepo});

  @override
  Future<Either<Failure, ActivityEntity>> call(
    Map<String, String> params,
  ) async {
    return await activityRepo.addActivity(params);
  }
}
