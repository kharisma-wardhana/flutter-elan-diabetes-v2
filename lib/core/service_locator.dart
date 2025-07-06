import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:health/health.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/user/datasource/remote/user_remote_datasource.dart';
import '../data/user/repository/user_repo_impl.dart';
import '../domain/auth/repository/user_repo.dart';
import '../domain/auth/usecase/login_usecase.dart';
import '../domain/auth/usecase/register_usecase.dart';
import '../domain/health/usecase/authorization_usecase.dart';
import '../domain/health/usecase/health_usecase.dart';
import '../presentation/auth/bloc/auth_bloc.dart';

import '../presentation/home/bloc/health_bloc.dart';
import 'api_service.dart';
import 'app_navigator.dart';
import 'constant.dart';
import 'dio_client.dart';

final sl = GetIt.instance;

class Injector {
  Future<void> initialize() async {
    await _registerSharedDependencies();
    _registerHealth();
    _registerDomains();
  }

  void _registerHealth() {
    sl.registerLazySingleton<Health>(() => Health());
  }

  Future<void> _registerSharedDependencies() async {
    await const SharedLibDependencies().registerCore();
  }

  void _registerDomains() {
    UserDependency();
    OnboardingDependency();
    HomeDependency();
  }
}

class SharedLibDependencies {
  const SharedLibDependencies();

  Future<void> registerCore() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    // sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
    sl.registerLazySingleton<AppNavigator>(() => AppNavigatorImpl());
    sl.registerLazySingleton<DioClient>(
      () => DioClient(baseUrl: baseURL, sharedPreferences: sl()),
    );
    sl.registerLazySingleton<ApiService>(
      () => ApiService(dio: sl<DioClient>().dio),
    );
    sl.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      ),
    );
  }
}

class UserDependency {
  UserDependency() {
    _registerDataSource();
    _registerRepository();
    _registerUseCases();
    _registerCubit();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(apiService: sl()),
    );
  }

  void _registerRepository() {
    sl.registerLazySingleton<UserRepository>(
      () => UserRepoImpl(sl<UserRemoteDatasource>()),
    );
  }

  void _registerUseCases() {
    sl.registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(sl<UserRepository>()),
    );
    sl.registerLazySingleton<RegisterUsecase>(
      () => RegisterUsecase(sl<UserRepository>()),
    );
  }

  void _registerCubit() {
    sl.registerLazySingleton(
      () => AuthBloc(
        loginUsecase: sl<LoginUsecase>(),
        registerUsecase: sl<RegisterUsecase>(),
        secureStorage: sl<FlutterSecureStorage>(),
      ),
    );
  }
}

class OnboardingDependency {}

class HomeDependency {
  HomeDependency() {
    _registerUseCases();
    _registerBloc();
  }

  void _registerUseCases() {
    // Register use cases related to home functionality here
    sl.registerLazySingleton<AuthorizationUsecase>(
      () => AuthorizationUsecase(sl<Health>()),
    );
    sl.registerLazySingleton<HealthUsecase>(() => HealthUsecase(sl<Health>()));
  }

  void _registerBloc() {
    // Register BLoC related to home functionality here
    sl.registerLazySingleton<HealthBloc>(
      () => HealthBloc(
        healthUsecase: sl<HealthUsecase>(),
        authorizationUsecase: sl<AuthorizationUsecase>(),
      ),
    );
  }
}
