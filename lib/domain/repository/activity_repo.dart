import 'package:dartz/dartz.dart';

import '../../core/error.dart';
import '../entities/activity/activity_entity.dart';

abstract class ActivityRepo {
  Future<Either<Failure, ActivityEntity>> addActivity(
    Map<String, String> activity,
  );
  Future<Either<Failure, List<ActivityEntity>>> getActivities();
}
