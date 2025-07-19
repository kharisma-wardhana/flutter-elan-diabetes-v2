import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/activity/activity_entity.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

@freezed
abstract class Activity with _$Activity {
  const Activity._();
  factory Activity({
    required int? id,
    @JsonKey(name: 'jenis') required String name,
    @JsonKey(name: 'tanggal') required String date,
    @JsonKey(name: 'jam') required int hour,
    @JsonKey(name: 'menit') required int minute,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  ActivityEntity toEntity() =>
      ActivityEntity(name: name, date: date, hour: hour, minute: minute);
}
