import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/doctor_entity.dart';

part 'doctor.freezed.dart';
part 'doctor.g.dart';

@freezed
abstract class Doctor with _$Doctor {
  const Doctor._();
  factory Doctor({
    required int id,
    @JsonKey(name: 'nama') required String name,
    @JsonKey(name: 'posisi') required String position,
    @JsonKey(name: 'wa') required String mobile,
    @JsonKey(name: 'foto') required String image,
  }) = _Doctor;

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  DoctorEntity mapDataToEntity() => DoctorEntity(
    id: id,
    name: name,
    position: position,
    mobile: mobile,
    image: image,
  );
}
