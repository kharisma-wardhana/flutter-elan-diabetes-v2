import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/app_navigator.dart';
import 'core/constant.dart';
import 'core/service_locator.dart';
import 'gen/colors.gen.dart';
import 'presentation/auth/bloc/auth_bloc.dart';
import 'presentation/auth/bloc/auth_event.dart';
import 'presentation/home/assesment/bloc/activity/activity_cubit.dart';
import 'presentation/home/assesment/bloc/antropometri/antropometri_cubit.dart';
import 'presentation/home/assesment/bloc/asam_urat/asam_urat_cubit.dart';
import 'presentation/home/assesment/bloc/ginjal/ginjal_cubit.dart';
import 'presentation/home/assesment/bloc/gula_darah/gula_cubit.dart';
import 'presentation/home/assesment/bloc/hb1ac/hb1ac_cubit.dart';
import 'presentation/home/assesment/bloc/kolesterol/kolesterol_cubit.dart';
import 'presentation/home/assesment/bloc/tekanan_darah/tensi_cubit.dart';
import 'presentation/home/assesment/bloc/water/water_cubit.dart';
import 'presentation/home/health/bloc/health_bloc.dart';
import 'presentation/home/health/bloc/health_event.dart';
import 'presentation/home/info/article/cubit/article_cubit.dart';
import 'presentation/home/info/doctor/cubit/doctor_cubit.dart';
import 'presentation/home/info/video/cubit/video_cubit.dart';
import 'presentation/onboarding/bloc/onboarding_bloc.dart';
import 'presentation/splash/page/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Injector().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800), // Set your design size here
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => sl<AuthBloc>()..add(AppStarted()),
          ),
          BlocProvider<OnboardingBloc>(create: (_) => sl<OnboardingBloc>()),
          BlocProvider<HealthBloc>(
            create: (_) => sl<HealthBloc>()..add(RequestPermissions()),
          ),
          BlocProvider(create: (context) => sl<ArticleCubit>()),
          BlocProvider(create: (context) => sl<DoctorCubit>()),
          BlocProvider(create: (context) => sl<VideoCubit>()),
          BlocProvider(create: (context) => sl<ActivityCubit>()),
          BlocProvider(create: (context) => sl<WaterCubit>()),
          BlocProvider(create: (context) => sl<AntropometriCubit>()),
          BlocProvider(create: (context) => sl<AsamUratCubit>()),
          BlocProvider(create: (context) => sl<GulaCubit>()),
          BlocProvider(create: (context) => sl<GinjalCubit>()),
          BlocProvider(create: (context) => sl<KolesterolCubit>()),
          BlocProvider(create: (context) => sl<TensiCubit>()),
          BlocProvider(create: (context) => sl<Hb1acCubit>()),
        ],
        child: MaterialApp(
          title: 'ELAN',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: ColorName.primary,
              titleTextStyle: TextStyle(
                color: ColorName.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              iconTheme: const IconThemeData(color: ColorName.white),
              toolbarHeight: 60.h,
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorName.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorName.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              floatingLabelStyle: TextStyle(
                color: ColorName.primary,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
              hintStyle: TextStyle(color: Colors.black, fontSize: 16.sp),
              errorMaxLines: 2,
              isDense: false,
            ),
            textTheme: TextTheme(
              bodyMedium: GoogleFonts.nunito().copyWith(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              bodyLarge: GoogleFonts.nunito().copyWith(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
              bodySmall: GoogleFonts.nunito().copyWith(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
              titleLarge: GoogleFonts.nunito().copyWith(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
              titleMedium: GoogleFonts.nunito().copyWith(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
              titleSmall: GoogleFonts.nunito().copyWith(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorName.primary,
                foregroundColor: ColorName.white,
                textStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: ColorName.primary,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              selectedLabelStyle: TextStyle(color: Colors.white),
              unselectedLabelStyle: TextStyle(color: Colors.white70),
            ),
          ),
          navigatorKey: AppNavigatorImpl.navigatorKey,
          onGenerateRoute: (RouteSettings settings) {
            final argument = settings.arguments;
            return AppRoutes.onGenerateRoutes(argument, settings.name);
          },
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        ),
      ),
      child: const SplashPage(),
    );
  }
}
