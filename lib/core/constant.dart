import 'package:flutter/material.dart';

import '../presentation/auth/page/login_page.dart';
import '../presentation/auth/page/register_page.dart';
import '../presentation/home/page/home_page.dart';
import '../presentation/onboarding/page/onboarding_page.dart';
import '../presentation/splash/page/splash_page.dart';

const String baseURL = 'https://elan.cmutiah.com/api';

// RouteName Config
const String splashPage = '/';
const String onboardingPage = '/onboarding';
const String loginPage = '/login';
const String registerPage = '/register';
const String homePage = '/home';
const String profileAppPage = '/about';
const String articlePage = '/articles';
const String edukasiPage = '/edukasi';
const String edukasiDetailPage = '/edukasi/detail';
const String detailArticlePage = '/articles/detail';
const String doctorPage = '/doctors';
const String catatanKesehatanPage = '/catatan-kesehatan';
// Assesment Page
const String antropometriPage = '/antropometri';
const String waterPage = '/water';
const String addWaterPage = '/water/add';
const String gulaPage = '/blood-sugar';
const String addGulaPage = '/blood-sugar/add';
const String aktifitasPage = '/activity';
const String addAktifitasPage = '/activity/add';
const String hbPage = '/hb1ac';
const String addHbPage = '/hb1ac/add';
const String tensiPage = '/blood-pressure';
const String addTensiPage = '/blood-pressure/add';
const String ginjalPage = '/kidney';
const String addGinjalPage = '/kidney/add';
const String kolesterolPage = '/kolesterol';
const String addKolesterolPage = '/kolesterol/add';
const String asamUratPage = '/gout';
const String addAsamUratPage = '/gout/add';
// =====================================
const String nutrisiPage = '/nutrisi';
const String addNutrisiPage = '/nutrisi/add';
const String obatPage = '/obat';
const String addObatPage = '/obat/add';
const String videoPage = '/video';

class AppRoutes {
  static MaterialPageRoute onGenerateRoutes(argument, name) {
    switch (name) {
      case splashPage:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case onboardingPage:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case registerPage:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
