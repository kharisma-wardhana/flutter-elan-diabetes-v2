import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/nutrition_entity.dart';

part 'nutrition.freezed.dart';
part 'nutrition.g.dart';

@freezed
abstract class Nutrition with _$Nutrition {
  const Nutrition._();
  factory Nutrition({
    required String type,
    required String total,
    required List<ItemData> data,
  }) = _Nutrition;

  factory Nutrition.fromJson(Map<String, dynamic> json) =>
      _$NutritionFromJson(json);

  NutritionEntity toEntity() => NutritionEntity(
    type: type,
    total: total,
    data: data.map((e) => e.toEntity()).toList(),
  );
}

@freezed
abstract class ItemData with _$ItemData {
  const ItemData._();
  const factory ItemData({
    required int id,
    @JsonKey(name: 'nama') required String name,
    @JsonKey(name: 'jumlah_kalori') required int total,
  }) = _ItemData;

  factory ItemData.fromJson(Map<String, dynamic> json) =>
      _$ItemDataFromJson(json);

  ItemDataEntity toEntity() => ItemDataEntity(id: id, name: name, total: total);
}
