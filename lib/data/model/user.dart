import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/user_entity.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const User._();
  const factory User({
    required int id,
    required String nama,
    required String mobile,
    required String email,
    required String gender,
    required String dob,
    String? token,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // Mapping to domain entity
  UserEntity toEntity() => UserEntity(
    id: id,
    name: nama,
    email: email,
    mobile: mobile,
    dob: dob,
    gender: gender,
    token: token,
  );
}
