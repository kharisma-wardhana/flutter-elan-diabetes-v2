import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/assesment/assesment_entity.dart';
import '../activity/activity.dart';
import '../asam_urat/asam_urat.dart';
import '../ginjal/ginjal.dart';
import '../gula_darah/gula_darah.dart';
import '../hb1ac/hb1ac.dart';
import '../kolesterol/kolesterol.dart';
import '../tekanan_darah/tekanan_darah.dart';
import '../water/water.dart';

part 'assesment.freezed.dart';
part 'assesment.g.dart';

@freezed
abstract class Assesment with _$Assesment {
  const Assesment._();
  const factory Assesment({
    @JsonKey(name: 'tekanan_darah') TekananDarah? tekananDarah,
    @JsonKey(name: 'gula_darah') GulaDarah? gulaDarah,
    @JsonKey(name: 'kolesterol') Kolesterol? kolesterol,
    @JsonKey(name: 'asam_urat') AsamUrat? asamUrat,
    @JsonKey(name: 'hb1ac') Hb1ac? hb1ac,
    @JsonKey(name: 'ginjal') Ginjal? ginjal,
    @JsonKey(name: 'water') Water? water,
  }) = _Assesment;

  factory Assesment.fromJson(Map<String, dynamic> json) =>
      _$AssesmentFromJson(json);

  AssesmentEntity toEntity() => AssesmentEntity(
    tensi: tekananDarah?.toEntity(),
    gula: gulaDarah?.toEntity(),
    kolesterol: kolesterol?.toEntity(),
    asamUrat: asamUrat?.toEntity(),
    hb1ac: hb1ac?.toEntity(),
    ginjal: ginjal?.toEntity(),
    water: water?.toEntity(),
  );
}
