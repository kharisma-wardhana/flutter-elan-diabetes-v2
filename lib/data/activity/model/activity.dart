import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/activity/entity/activity_entity.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

@freezed
abstract class Activity with _$Activity {
  const Activity._();
  const factory Activity({required String name, required String date}) =
      _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  ActivityEntity toEntity() => ActivityEntity(name: name, date: date);
}
