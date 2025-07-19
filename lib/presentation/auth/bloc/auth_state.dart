import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/auth/user_entity.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.success({required UserEntity userEntity}) =
      AuthSuccess;
  const factory AuthState.error({required String message}) = AuthError;
}
