import 'package:elan_diabetes/presentation/bloc/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/datasource/remote/user_remote_datasource.dart';
import '../data/repository/user_repo_impl.dart';
import '../domain/repository/user_repo.dart';
import '../domain/usecase/login_usecase.dart';
import '../domain/usecase/register_usecase.dart';
import 'api_service.dart';
import 'constant.dart';
import 'dio_client.dart';

final sl = GetIt.instance;

class Injector {
  Future<void> initialize() async {
    await _registerSharedDependencies();
    _registerDomains();
  }

  Future<void> _registerSharedDependencies() async {
    await const SharedLibDependencies().registerCore();
  }

  void _registerDomains() {
    UserDependency();
    // HomeDependency();
    // AssesmentDependency();
  }
}

class SharedLibDependencies {
  const SharedLibDependencies();

  Future<void> registerCore() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    // sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
    // sl.registerLazySingleton<NavigationHelper>(() => NavigationHelperImpl());
    sl.registerLazySingleton<DioClient>(
      () => DioClient(baseUrl: baseURL, sharedPreferences: sl()),
    );
    sl.registerLazySingleton<ApiService>(
      () => ApiService(dio: sl<DioClient>().dio),
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
      () => AuthBloc(sl<LoginUsecase>(), sl<RegisterUsecase>()),
    );
  }
}
