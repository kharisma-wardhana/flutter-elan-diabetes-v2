import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:health/health.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/datasource/remote/activity_remote_datasource.dart';
import '../data/datasource/remote/article_remote_datasource.dart';
import '../data/datasource/remote/assesment_remote_datasource.dart';
import '../data/datasource/remote/doctor_remote_datasource.dart';
import '../data/datasource/remote/video_remote_datasource.dart';
import '../data/repository/activity_repo_impl.dart';
import '../data/datasource/remote/gula_darah_remote_datasource.dart';
import '../data/repository/article_repository_impl.dart';
import '../data/repository/assesment_repository_impl.dart';
import '../data/repository/doctor_repository_impl.dart';
import '../data/repository/gula_darah_repo_impl.dart';
import '../data/datasource/remote/user_remote_datasource.dart';
import '../data/repository/user_repo_impl.dart';
import '../data/repository/video_repository_impl.dart';
import '../domain/repository/activity_repo.dart';
import '../domain/repository/article_repository.dart';
import '../domain/repository/assesment_repository.dart';
import '../domain/repository/doctor_repository.dart';
import '../domain/repository/video_repository.dart';
import '../domain/usecase/activity/add_activity_usecase.dart';
import '../domain/repository/user_repo.dart';
import '../domain/usecase/article/get_detail_article.dart';
import '../domain/usecase/article/get_list_articles.dart';
import '../domain/usecase/assesment/add_activity_usecase.dart';
import '../domain/usecase/assesment/add_antropometri_usecase.dart';
import '../domain/usecase/assesment/add_asam_urat_usecase.dart';
import '../domain/usecase/assesment/add_blood_pressure_usecase.dart';
import '../domain/usecase/assesment/add_blood_sugar_usecase.dart';
import '../domain/usecase/assesment/add_ginjal_usecase.dart';
import '../domain/usecase/assesment/add_hb_usecase.dart';
import '../domain/usecase/assesment/add_kolesterol_usecase.dart';
import '../domain/usecase/assesment/add_water_usecase.dart';
import '../domain/usecase/assesment/get_assesment_usecase.dart';
import '../domain/usecase/assesment/get_detail_antropometri_usecase.dart';
import '../domain/usecase/assesment/get_list_activity_usecase.dart';
import '../domain/usecase/assesment/get_list_asam_urat_usecase.dart';
import '../domain/usecase/assesment/get_list_blood_pressure_usecase.dart';
import '../domain/usecase/assesment/get_list_blood_sugar_usecase.dart';
import '../domain/usecase/assesment/get_list_ginjal_usecase.dart';
import '../domain/usecase/assesment/get_list_hb_usecase.dart';
import '../domain/usecase/assesment/get_list_kolesterol_usecase.dart';
import '../domain/usecase/assesment/get_list_water_usecase.dart';
import '../domain/usecase/auth/login_usecase.dart';
import '../domain/usecase/auth/register_usecase.dart';
import '../domain/repository/gula_darah_repo.dart';
import '../domain/usecase/doctor/get_all_doctor_usecase.dart';
import '../domain/usecase/gula_darah/add_gula_darah_usecase.dart';
import '../domain/usecase/health/authorization_usecase.dart';
import '../domain/usecase/health/health_usecase.dart';
import '../domain/usecase/video/get_list_video_usecase.dart';
import '../presentation/auth/bloc/auth_bloc.dart';

import '../presentation/home/assesment/bloc/activity/activity_cubit.dart';
import '../presentation/home/assesment/bloc/antropometri/antropometri_cubit.dart';
import '../presentation/home/assesment/bloc/asam_urat/asam_urat_cubit.dart';
import '../presentation/home/assesment/bloc/assesment/assesment_cubit.dart';
import '../presentation/home/assesment/bloc/ginjal/ginjal_cubit.dart';
import '../presentation/home/assesment/bloc/gula_darah/gula_cubit.dart';
import '../presentation/home/assesment/bloc/hb1ac/hb1ac_cubit.dart';
import '../presentation/home/assesment/bloc/kolesterol/kolesterol_cubit.dart';
import '../presentation/home/assesment/bloc/tekanan_darah/tensi_cubit.dart';
import '../presentation/home/assesment/bloc/water/water_cubit.dart';
import '../presentation/home/health/bloc/health_bloc.dart';
import '../presentation/home/info/article/cubit/article_cubit.dart';
import '../presentation/home/info/doctor/cubit/doctor_cubit.dart';
import '../presentation/home/info/video/cubit/video_cubit.dart';
import '../presentation/onboarding/bloc/onboarding_bloc.dart';
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
    AssesmentDependency();
    InfoDependency();
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
      () => DioClient(baseUrl: baseURL, secureStorage: sl()),
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

class OnboardingDependency {
  OnboardingDependency() {
    _registerDataSource();
    _registerRepository();
    _registerUseCases();
    _registerBloc();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<GulaDarahRemoteDataSource>(
      () => GulaDarahRemoteDataSourceImpl(apiService: sl<ApiService>()),
    );
    sl.registerLazySingleton<ActivityRemoteDatasource>(
      () => ActivityRemoteDatasourceImpl(apiService: sl<ApiService>()),
    );
  }

  void _registerRepository() {
    sl.registerLazySingleton<GulaDarahRepository>(
      () => GulaDarahRepoImpl(
        gulaDarahRemoteDataSource: sl<GulaDarahRemoteDataSource>(),
      ),
    );
    sl.registerLazySingleton<ActivityRepo>(
      () => ActivityRepoImpl(
        activityRemoteDatasource: sl<ActivityRemoteDatasource>(),
      ),
    );
  }

  void _registerUseCases() {
    // Register use cases related to onboarding functionality here
    sl.registerLazySingleton<AddGulaDarahUsecase>(
      () => AddGulaDarahUsecase(sl<GulaDarahRepository>()),
    );
    sl.registerLazySingleton<AddActivityUsecase>(
      () => AddActivityUsecase(activityRepo: sl<ActivityRepo>()),
    );
  }

  void _registerBloc() {
    // Register BLoC related to onboarding functionality here
    sl.registerLazySingleton<OnboardingBloc>(
      () => OnboardingBloc(
        secureStorage: sl<FlutterSecureStorage>(),
        addActivityUsecase: sl<AddActivityUsecase>(),
        addGulaDarahUsecase: sl<AddGulaDarahUsecase>(),
      ),
    );
  }
}

class HomeDependency {
  HomeDependency() {
    _registerUseCases();
    _registerCubit();
  }

  void _registerUseCases() {
    // Register use cases related to home functionality here
    sl.registerLazySingleton<AuthorizationUsecase>(
      () => AuthorizationUsecase(sl<Health>()),
    );
    sl.registerLazySingleton<HealthUsecase>(() => HealthUsecase(sl<Health>()));
  }

  void _registerCubit() {
    // Register BLoC related to home functionality here
    sl.registerLazySingleton<HealthBloc>(
      () => HealthBloc(
        healthUsecase: sl<HealthUsecase>(),
        authorizationUsecase: sl<AuthorizationUsecase>(),
      ),
    );
  }
}

class AssesmentDependency {
  AssesmentDependency() {
    _registerDataSource();
    _registerRepository();
    _registerUseCases();
    _registerCubit();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<AssesmentRemoteDatasource>(
      () => AssesmentRemoteDatasourceImpl(
        apiService: sl(),
        sharedPreferences: sl(),
      ),
    );
  }

  void _registerRepository() {
    sl.registerLazySingleton<AssesmentRepository>(
      () => AssesmentRepositoryImpl(
        assesmentRemoteDatasource: sl<AssesmentRemoteDatasource>(),
        secureStorage: sl<FlutterSecureStorage>(),
      ),
    );
  }

  void _registerUseCases() {
    sl.registerLazySingleton<GetAssesmentUsecase>(
      () => GetAssesmentUsecase(assesmentRepository: sl<AssesmentRepository>()),
    );

    sl.registerLazySingleton<GetListWaterUseCase>(
      () => GetListWaterUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton<AddWaterUseCase>(
      () => AddWaterUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );

    sl.registerLazySingleton<GetListActivityUseCase>(
      () => GetListActivityUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton<AddActivityUseCase>(
      () => AddActivityUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );

    sl.registerLazySingleton<AddAntropometriUseCase>(
      () => AddAntropometriUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton<GetDetailAntropometriUsecase>(
      () => GetDetailAntropometriUsecase(
        assesmentRepo: sl<AssesmentRepository>(),
      ),
    );

    sl.registerLazySingleton<AddAsamUratUsecase>(
      () => AddAsamUratUsecase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton<GetListAsamUratUsecase>(
      () => GetListAsamUratUsecase(assesmentRepo: sl<AssesmentRepository>()),
    );

    sl.registerLazySingleton<GetListBloodPressureUseCase>(
      () =>
          GetListBloodPressureUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton<AddBloodPressureUseCase>(
      () => AddBloodPressureUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );

    sl.registerLazySingleton<GetListBloodSugarUseCase>(
      () => GetListBloodSugarUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton<AddBloodSugarUseCase>(
      () => AddBloodSugarUseCase(assesmentRepo: sl<AssesmentRepository>()),
    );

    sl.registerLazySingleton<AddGinjalUsecase>(
      () => AddGinjalUsecase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton<GetListGinjalUsecase>(
      () => GetListGinjalUsecase(assesmentRepo: sl<AssesmentRepository>()),
    );

    sl.registerLazySingleton<GetListKolesterolUsecase>(
      () => GetListKolesterolUsecase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton<AddKolesterolUsecase>(
      () => AddKolesterolUsecase(assesmentRepo: sl<AssesmentRepository>()),
    );

    sl.registerLazySingleton<GetListHbUsecase>(
      () => GetListHbUsecase(assesmentRepo: sl<AssesmentRepository>()),
    );
    sl.registerLazySingleton<AddHbUsecase>(
      () => AddHbUsecase(assesmentRepo: sl<AssesmentRepository>()),
    );
  }

  void _registerCubit() {
    sl.registerLazySingleton<AssesmentCubit>(
      () => AssesmentCubit(getAssesmentUsecase: sl<GetAssesmentUsecase>()),
    );
    sl.registerLazySingleton<ActivityCubit>(
      () => ActivityCubit(
        getListActivityUseCase: sl<GetListActivityUseCase>(),
        addActivityUseCase: sl<AddActivityUseCase>(),
      ),
    );
    sl.registerLazySingleton<WaterCubit>(
      () => WaterCubit(
        getListWaterUseCase: sl<GetListWaterUseCase>(),
        addWaterUseCase: sl<AddWaterUseCase>(),
      ),
    );
    sl.registerLazySingleton<AntropometriCubit>(
      () => AntropometriCubit(
        antropometriUseCase: sl<AddAntropometriUseCase>(),
        getDetailAntropometriUsecase: sl<GetDetailAntropometriUsecase>(),
        secureStorage: sl<FlutterSecureStorage>(),
      ),
    );
    sl.registerLazySingleton<GinjalCubit>(
      () => GinjalCubit(
        getListGinjalUsecase: sl<GetListGinjalUsecase>(),
        addGinjalUsecase: sl<AddGinjalUsecase>(),
      ),
    );
    sl.registerLazySingleton<GulaCubit>(
      () => GulaCubit(
        getListBloodSugarUseCase: sl<GetListBloodSugarUseCase>(),
        addBloodSugarUseCase: sl<AddBloodSugarUseCase>(),
      ),
    );
    sl.registerLazySingleton<Hb1acCubit>(
      () => Hb1acCubit(
        getListHbUsecase: sl<GetListHbUsecase>(),
        addHbUsecase: sl<AddHbUsecase>(),
      ),
    );
    sl.registerLazySingleton<TensiCubit>(
      () => TensiCubit(
        getListTekananDarahUseCase: sl<GetListBloodPressureUseCase>(),
        addBloodPressureUseCase: sl<AddBloodPressureUseCase>(),
      ),
    );
    sl.registerLazySingleton<KolesterolCubit>(
      () => KolesterolCubit(
        getListKolesterolUsecase: sl<GetListKolesterolUsecase>(),
        addKolesterolUsecase: sl<AddKolesterolUsecase>(),
      ),
    );
    sl.registerLazySingleton<AsamUratCubit>(
      () => AsamUratCubit(
        getListAsamUratUsecase: sl<GetListAsamUratUsecase>(),
        addAsamUratUsecase: sl<AddAsamUratUsecase>(),
      ),
    );
  }
}

class InfoDependency {
  InfoDependency() {
    _registerDataSource();
    _registerRepository();
    _registerUseCases();
    _registerCubit();
  }

  void _registerDataSource() {
    sl.registerLazySingleton<ArticleRemoteDatasource>(
      () => ArticleRemoteDatasourceImpl(apiService: sl<ApiService>()),
    );
    sl.registerLazySingleton<DoctorRemoteDatasource>(
      () => DoctorRemoteDatasourceImpl(apiService: sl<ApiService>()),
    );
    sl.registerLazySingleton<VideoRemoteDatasource>(
      () => VideoRemoteDatasourceImpl(apiService: sl<ApiService>()),
    );
  }

  void _registerRepository() {
    sl.registerLazySingleton<ArticleRepository>(
      () => ArticleRepositoryImpl(
        articleRemoteDatasource: sl<ArticleRemoteDatasource>(),
      ),
    );
    sl.registerLazySingleton<DoctorRepository>(
      () => DoctorRepositoryImpl(
        doctorRemoteDatasource: sl<DoctorRemoteDatasource>(),
      ),
    );
    sl.registerLazySingleton<VideoRepository>(
      () => VideoRepositoryImpl(
        videoRemoteDatasource: sl<VideoRemoteDatasource>(),
      ),
    );
  }

  void _registerUseCases() {
    sl.registerLazySingleton<GetListArticles>(
      () => GetListArticles(articleRepo: sl<ArticleRepository>()),
    );
    sl.registerLazySingleton<GetDetailArticle>(
      () => GetDetailArticle(articleRepo: sl<ArticleRepository>()),
    );
    sl.registerLazySingleton<GetAllDoctorUsecase>(
      () => GetAllDoctorUsecase(doctorRepo: sl<DoctorRepository>()),
    );
    sl.registerLazySingleton<GetListVideoUsecase>(
      () => GetListVideoUsecase(videoRepo: sl<VideoRepository>()),
    );
  }

  void _registerCubit() {
    sl.registerLazySingleton(
      () => ArticleCubit(
        getListArticles: sl<GetListArticles>(),
        getDetailArticle: sl<GetDetailArticle>(),
      ),
    );
    sl.registerLazySingleton<DoctorCubit>(
      () => DoctorCubit(getAllDoctorUseCase: sl<GetAllDoctorUsecase>()),
    );
    sl.registerLazySingleton<VideoCubit>(
      () => VideoCubit(getListVideoUseCase: sl<GetListVideoUsecase>()),
    );
  }
}
