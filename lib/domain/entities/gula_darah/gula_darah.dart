import 'package:freezed_annotation/freezed_annotation.dart';

part 'gula_darah.freezed.dart';
part 'gula_darah.g.dart';

@freezed
abstract class GulaDarahEntity with _$GulaDarahEntity {
  const GulaDarahEntity._();
  factory GulaDarahEntity({
    @JsonKey(name: 'tanggal') required String date,
    @JsonKey(name: 'jam') required String time,
    @JsonKey(name: 'type') required int type,
    @JsonKey(name: 'kadar') required String total,
  }) = _GulaDarahEntity;

  factory GulaDarahEntity.fromJson(Map<String, dynamic> json) =>
      _$GulaDarahEntityFromJson(json);
}
