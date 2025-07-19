import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/antropometri_entity.dart';

part 'antropometri.freezed.dart';
part 'antropometri.g.dart';

@freezed
abstract class Antropometri with _$Antropometri {
  const Antropometri._();
  factory Antropometri({
    required int id,
    @JsonKey(name: 'users_id') required String usersId,
    @JsonKey(name: 'tinggi') required double height,
    @JsonKey(name: 'berat') required double weight,
    @JsonKey(name: 'lingkar_lengan') required double hand,
    @JsonKey(name: 'lingkar_perut') required double stomach,
    @JsonKey(name: 'hasil') required double result,
    @JsonKey(name: 'jenis_aktivitas') String? activity,
    @JsonKey(name: 'status') required int status,
  }) = _Antropometri;

  factory Antropometri.fromJson(Map<String, dynamic> json) =>
      _$AntropometriFromJson(json);

  AntropometriEntity toEntity() => AntropometriEntity(
    height: height,
    weight: weight,
    stomach: stomach,
    hand: hand,
    result: result,
    status: status == 0
        ? 'Kurang'
        : status == 1
        ? 'Normal'
        : 'Lebih',
    activity: activity,
  );
}
