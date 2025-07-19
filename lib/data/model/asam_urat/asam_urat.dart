import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/asam_urat_entity.dart';

part 'asam_urat.freezed.dart';
part 'asam_urat.g.dart';

@freezed
abstract class AsamUrat with _$AsamUrat {
  const AsamUrat._();
  factory AsamUrat({
    @JsonKey(name: 'tanggal') required String date,
    @JsonKey(name: 'jumlah') required double total,
  }) = _AsamUrat;

  factory AsamUrat.fromJson(Map<String, dynamic> json) =>
      _$AsamUratFromJson(json);

  AsamUratEntity toEntity() => AsamUratEntity(date: date, total: total);
}
