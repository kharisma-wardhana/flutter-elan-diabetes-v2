import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/medicine_entity.dart';

part 'medicine.freezed.dart';
part 'medicine.g.dart';

@freezed
abstract class Medicine with _$Medicine {
  const Medicine._();
  factory Medicine({
    required int id,
    @JsonKey(name: 'users_id') required int usersId,
    @JsonKey(name: 'tanggal') required String date,
    @JsonKey(name: 'nama') required String name,
    required String dosis,
    required int type,
    int? status,
  }) = _Medicine;

  factory Medicine.fromJson(Map<String, dynamic> json) =>
      _$MedicineFromJson(json);

  MedicineEntity toEntity() => MedicineEntity(
    id: id,
    date: date,
    name: name,
    dosis: dosis,
    type: type,
    status: status ?? 0,
  );
}
