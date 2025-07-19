import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/kolesterol_entity.dart';

part 'kolesterol.freezed.dart';
part 'kolesterol.g.dart';

@freezed
abstract class Kolesterol with _$Kolesterol {
  const Kolesterol._();
  factory Kolesterol({
    @JsonKey(name: 'tanggal') required String date,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'kadar_kolesterol') required String total,
  }) = _Kolesterol;

  factory Kolesterol.fromJson(Map<String, dynamic> json) =>
      _$KolesterolFromJson(json);

  KolesterolEntity toEntity() =>
      KolesterolEntity(date: date, type: type, total: int.parse(total));
}
