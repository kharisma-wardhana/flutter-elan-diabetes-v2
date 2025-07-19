import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/ginjal_entity.dart';

part 'ginjal.freezed.dart';
part 'ginjal.g.dart';

@freezed
abstract class Ginjal with _$Ginjal {
  const Ginjal._();
  factory Ginjal({
    @JsonKey(name: 'tanggal') required String date,
    @JsonKey(name: 'type') required int type,
    @JsonKey(name: 'jumlah') required double total,
  }) = _Ginjal;

  factory Ginjal.fromJson(Map<String, dynamic> json) => _$GinjalFromJson(json);

  GinjalEntity toEntity() => GinjalEntity(date: date, type: type, total: total);
}
