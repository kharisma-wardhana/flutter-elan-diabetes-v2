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
            create: (_) => sl<AuthBloc>()..add(const AuthEvent.appStarted()),
          ),
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
          ),
          home: child,
          navigatorKey: AppNavigatorImpl.navigatorKey,
          onGenerateRoute: (RouteSettings settings) {
            final argument = settings.arguments;
            return AppRoutes.onGenerateRoutes(argument, settings.name);
          },
        ),
      ),
      child: const SplashPage(),
    );
  }
}
