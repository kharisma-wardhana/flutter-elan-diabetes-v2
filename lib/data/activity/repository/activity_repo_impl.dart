import 'package:dartz/dartz.dart';

import '../../../core/error.dart';
import '../../../domain/activity/entity/activity_entity.dart';
import '../../../domain/activity/repository/activity_repo.dart';
import '../datasource/remote/activity_remote_datasource.dart';
import '../model/activity.dart';

class ActivityRepoImpl implements ActivityRepo {
  final ActivityRemoteDatasource activityRemoteDatasource;

  ActivityRepoImpl({required this.activityRemoteDatasource});

  @override
  Future<Either<Failure, ActivityEntity>> addActivity(
    Map<String, String> params,
  ) async {
    try {
      Activity act = Activity(
        name: params['name'] ?? '',
        date: DateTime.now().toIso8601String(),
      );
      final result = await activityRemoteDatasource.addActivity(act);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ActivityEntity>>> getActivities() {
    // TODO: implement getActivities
    throw UnimplementedError();
  }
}
