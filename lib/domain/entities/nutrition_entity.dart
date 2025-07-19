import 'package:equatable/equatable.dart';

class NutritionEntity extends Equatable {
  final String type;
  final String total;
  final List<ItemDataEntity>? data;
  final String? date;
  final String? name;

  const NutritionEntity({
    required this.type,
    required this.total,
    this.data,
    this.date,
    this.name,
  });

  @override
  List<Object?> get props => [
        type,
        total,
      ];
}

class ItemDataEntity extends Equatable {
  final int id;
  final String name;
  final int total;

  const ItemDataEntity({
    required this.id,
    required this.name,
    required this.total,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        total,
      ];
}
