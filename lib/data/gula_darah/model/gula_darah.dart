import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/gula_darah/entity/gula_darah_entity.dart';

part 'gula_darah.freezed.dart';
part 'gula_darah.g.dart';

@freezed
abstract class GulaDarah with _$GulaDarah {
  const GulaDarah._();
  const factory GulaDarah({
    @JsonKey(name: "user_id") required int userID,
    required String tanggal,
    required String jam,
    required String kadar,
    required String type,
  }) = _GulaDarah;

  factory GulaDarah.fromJson(Map<String, dynamic> json) =>
      _$GulaDarahFromJson(json);

  GulaDarahEntity toEntity() => GulaDarahEntity(value: kadar, date: tanggal);
}
