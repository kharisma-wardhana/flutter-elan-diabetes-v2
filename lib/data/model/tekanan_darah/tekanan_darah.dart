import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/tensi_entity.dart';

part 'tekanan_darah.freezed.dart';
part 'tekanan_darah.g.dart';

@freezed
abstract class TekananDarah with _$TekananDarah {
  const TekananDarah._();
  factory TekananDarah({
    @JsonKey(name: 'tanggal') required String date,
    @JsonKey(name: 'jam') required String time,
    required int sistole,
    required int diastole,
  }) = _TekananDarah;

  factory TekananDarah.fromJson(Map<String, dynamic> json) =>
      _$TekananDarahFromJson(json);

  TensiEntity toEntity() =>
      TensiEntity(date: date, time: time, sistole: sistole, diastole: diastole);
}
