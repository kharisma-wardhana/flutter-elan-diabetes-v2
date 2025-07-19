import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/hb1ac_entity.dart';

part 'hb1ac.freezed.dart';
part 'hb1ac.g.dart';

@freezed
abstract class Hb1ac with _$Hb1ac {
  const Hb1ac._();
  factory Hb1ac({
    @JsonKey(name: 'tanggal') required String date,
    @JsonKey(name: 'jumlah') required double total,
  }) = _Hb1ac;

  factory Hb1ac.fromJson(Map<String, dynamic> json) => _$Hb1acFromJson(json);

  Hb1acEntity toEntity() => Hb1acEntity(date: date, total: total);
}
