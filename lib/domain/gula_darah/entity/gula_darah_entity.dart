import 'package:freezed_annotation/freezed_annotation.dart';

part 'gula_darah_entity.freezed.dart';
part 'gula_darah_entity.g.dart';

@freezed
abstract class GulaDarahEntity with _$GulaDarahEntity {
  const factory GulaDarahEntity({
    required int id,
    required String value,
    required String date,
  }) = _GulaDarahEntity;

  factory GulaDarahEntity.fromJson(Map<String, dynamic> json) =>
      _$GulaDarahEntityFromJson(json);
}
