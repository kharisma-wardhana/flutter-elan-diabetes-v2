import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/user/model/user.dart';
import '../../../domain/auth/usecase/login_usecase.dart';
import '../../../domain/auth/usecase/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final FlutterSecureStorage secureStorage;

  static const String _tokenKey = 'auth_token';

  AuthBloc({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.secureStorage,
  }) : super(const AuthState.initial()) {
    on<LoginEvent>((event, emit) async {
      emit(const AuthState.loading());
      try {
        final result = await loginUsecase.call({
          'email': event.username,
          'password': event.password,
        });
        result.fold(
          (failure) => emit(
            AuthState.error(
              message: failure.message.isNotEmpty
                  ? failure.message
                  : 'Login failed. Please check your credentials and try again.',
            ),
          ),
          (user) {
            secureStorage.write(
              key: _tokenKey,
              value: jsonEncode(user.toJson()),
            );
            emit(AuthState.success(userEntity: user));
          },
        );
      } catch (e) {
        emit(AuthState.error(message: e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) {
      emit(const AuthState.initial());
    });

    on<RegisterEvent>((event, emit) async {
      emit(const AuthState.loading());
      try {
        final result = await registerUsecase.call({
          'name': event.name,
          'email': event.email,
          'mobile': event.mobile,
          'dob': event.dob,
          'gender': event.gender,
        });
        result.fold(
          (failure) => emit(AuthState.error(message: failure.message)),
          (user) {
            secureStorage.write(key: _tokenKey, value: jsonEncode(user));
            emit(AuthState.success(userEntity: user));
          },
        );
      } catch (e) {
        emit(AuthState.error(message: e.toString()));
      }
    });

    on<AppStarted>((event, emit) async {
      final token = await secureStorage.read(key: _tokenKey);
      if (token != null) {
        final userJson = jsonDecode(token);
        final user = User.fromJson(userJson);
        emit(AuthState.success(userEntity: user.toEntity()));
      } else {
        emit(const AuthState.initial());
      }
    });

    on<CompleteOnboardingEvent>((event, emit) async {
      if (state is AuthSuccess) {
        final currentUser = (state as AuthSuccess).userEntity;
        final updatedUser = currentUser.copyWith(isOnboardingComplete: true);

        // Update the user in secure storage
        await secureStorage.write(
          key: _tokenKey,
          value: jsonEncode(updatedUser.toJson()),
        );

        emit(AuthState.success(userEntity: updatedUser));
      }
    });
  }
}
