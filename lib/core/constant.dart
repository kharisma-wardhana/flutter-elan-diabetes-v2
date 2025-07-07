import 'package:elan/presentation/onboarding/page/activity_page.dart';
import 'package:flutter/material.dart';

import '../presentation/auth/page/login_page.dart';
import '../presentation/auth/page/register_page.dart';
import '../presentation/home/page/home_page.dart';
import '../presentation/onboarding/page/gula_darah_page.dart';
import '../presentation/onboarding/page/onboarding_page.dart';
import '../presentation/onboarding/page/recommendation_page.dart';
import '../presentation/profile/page/profile_page.dart';
import '../presentation/splash/page/splash_page.dart';

const String baseURL = 'https://elan.cmutiah.com/api';

// RouteName Config
const String splashPage = '/';
const String loginPage = '/login';
const String registerPage = '/register';
const String onboardingPage = '/onboarding';
const String gulaDarahPage = '/check-gula-darah';
const String recommendationPage = '/recommendation';
const String activityPage = '/activity';
const String homePage = '/home';
const String profilePage = '/profile';

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
      case gulaDarahPage:
        return MaterialPageRoute(builder: (_) => const GulaDarahPage());
      case recommendationPage:
        return MaterialPageRoute(
          builder: (context) {
            final args = argument ?? <String>[];
            return RecommendationPage(data: args);
          },
        );
      case activityPage:
        return MaterialPageRoute(builder: (_) => const ActivityPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}

List<String> questions = [
  'Apakah Anda mengalami gejala seperti sering haus, sering buang air kecil?',
  'Apakah Anda sering merasa lemas, lapar berlebihan, atau berat badan turun dratis?',
  'Apakah Anda memiliki riwayat diabetes di keluarga (ayah/ibu/saudara)?',
  'Apakah Anda memiliki tekanan darah tinggi atau kolesterol tinggi?',
  'Apakah Anda berusia diatas 40 tahun dan jarang bergerak?',
];

Map<String, List<String>> recommendations = {
  'normal': [
    'Pertahankan pola makan sehat (sayur, buah, dan hindari konsumsi gula hingga minyak berlebih).',
    'Lakukan aktivitas fisik teratur minimal 30 menit setiap hari.',
    'Pemeriksaan Gula Darah ulang tiap 3 bulan.',
    'Pantau Tekanan Darah dan Berat Badan.',
  ],
  'diabetes': [
    'Konsultasikan segera dengan dokter untuk rencana pengobatan.',
    'Mulai diet DM (rendah gula dan karbohidrat, makanan tinggi serat seperti sayur dan buah yang tidak terlalu manis, makanan rendah garam/natrium, hindari makanan yang digoreng/dibakar, dan makanan siap saji/diawetkan).',
    'Lakukan aktivitas fisik ringan (jalan kaki dan senam ringan).',
    'Monitor gula darah setiap hari atau minimal 3 kali seminggu.',
    'Istirahat yang cukup yaitu 6 s.d 8 jam per hari.',
    'Lakukan pemeriksaan kaki dan mata secara berkala.',
    'Ikuti edukasi DM secara berkala bersama sudah perawat/dokter/tenaga kesehatan.',
  ],
};
