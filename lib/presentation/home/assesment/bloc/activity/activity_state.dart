import 'package:equatable/equatable.dart';

import '../../../../../core/state_enum.dart';
import '../../../../../domain/entities/activity/activity_entity.dart';

class ActivityState extends Equatable {
  final ViewData<List<ActivityEntity>> activityState;

  const ActivityState({required this.activityState});

  @override
  List<Object?> get props => [activityState];
}
