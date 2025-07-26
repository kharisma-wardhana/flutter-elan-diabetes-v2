import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/gula_darah/gula_darah.dart';

part 'gula_darah.freezed.dart';
part 'gula_darah.g.dart';

@freezed
abstract class GulaDarah with _$GulaDarah {
  const GulaDarah._();
  const factory GulaDarah({
    int? id,
    @JsonKey(name: "users_id") required String userID,
    required String tanggal,
    required String jam,
    required String kadar,
    required int type,
  }) = _GulaDarah;

  factory GulaDarah.fromJson(Map<String, dynamic> json) =>
      _$GulaDarahFromJson(json);

  GulaDarahEntity toEntity() =>
      GulaDarahEntity(date: tanggal, time: jam, type: type, total: kadar);
}
