import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_entity.freezed.dart';
part 'activity_entity.g.dart';

@freezed
abstract class ActivityEntity with _$ActivityEntity {
  const ActivityEntity._();
  const factory ActivityEntity({required String name, required String date}) =
      _ActivityEntity;

  factory ActivityEntity.fromJson(Map<String, dynamic> json) =>
      _$ActivityEntityFromJson(json);
}
