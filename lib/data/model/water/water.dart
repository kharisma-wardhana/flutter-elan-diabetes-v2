import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/water_entity.dart';

part 'water.freezed.dart';
part 'water.g.dart';

@freezed
abstract class Water with _$Water {
  const Water._();
  factory Water({
    required int id,
    @JsonKey(name: 'users_id') required String usersId,
    @JsonKey(name: 'tanggal') required String date,
    @JsonKey(name: 'target') required int target,
    @JsonKey(name: 'jumlah') required int total,
  }) = _Water;

  factory Water.fromJson(Map<String, dynamic> json) => _$WaterFromJson(json);

  WaterEntity toEntity() =>
      WaterEntity(date: date, target: target, total: total);
}
