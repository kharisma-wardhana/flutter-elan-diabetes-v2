import 'dart:convert';

import 'package:elan_diabetes/data/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/usecase/login_usecase.dart';
import '../../../domain/usecase/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';

  AuthBloc(this.loginUsecase, this.registerUsecase)
    : super(const AuthState.initial()) {
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
            _secureStorage.write(key: _tokenKey, value: jsonEncode(user));
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
        });
        result.fold(
          (failure) => emit(AuthState.error(message: failure.message)),
          (user) {
            _secureStorage.write(key: _tokenKey, value: jsonEncode(user));
            emit(AuthState.success(userEntity: user));
          },
        );
      } catch (e) {
        emit(AuthState.error(message: e.toString()));
      }
    });

    on<AppStarted>((event, emit) async {
      final token = await _secureStorage.read(key: _tokenKey);
      if (token != null) {
        final userJson = jsonDecode(token);
        final user = User.fromJson(userJson);
        emit(AuthState.success(userEntity: user.toEntity()));
      } else {
        emit(const AuthState.initial());
      }
    });
  }
}
