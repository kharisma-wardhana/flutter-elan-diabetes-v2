import 'package:flutter/material.dart';

import '../presentation/auth/page/login_page.dart';
import '../presentation/auth/page/register_page.dart';
import '../presentation/home/page/home_page.dart';
import '../presentation/onboarding/page/gula_darah_page.dart';
import '../presentation/onboarding/page/onboarding_page.dart';
import '../presentation/onboarding/page/recommendation_page.dart';
import '../presentation/splash/page/splash_page.dart';

const String baseURL = 'https://elan.cmutiah.com/api';

// RouteName Config
const String splashPage = '/';
const String onboardingPage = '/onboarding';
const String loginPage = '/login';
const String registerPage = '/register';
const String homePage = '/home';
const String gulaDarahPage = '/check-gula-darah';
const String recommendationPage = '/recommendation';

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
            final args = ModalRoute.of(context)?.settings.arguments;
            final data = args is List<String> ? args : <String>[];
            return RecommendationPage(data: data);
          },
        );
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

List<String> questions = [
  'Apakah Anda mengalami gejala seperti sering haus, sering buang air kecil?',
  'Apakah Anda sering merasa lemas, lapar berlebihan, atau berat badan turun dratis?',
  'Apakah Anda memiliki riwayat diabetes di keluarga (ayah/ibu/saudara)?',
  'Apakah Anda memiliki tekanan darah tinggi atau kolesterol tinggi?',
  'Apakah Anda berusia diatas 40 tahun dan jarang bergerak?',
];
List<String> answers = [];
List<bool> isAnswered = [];

Map<String, List<String>> recommendations = {
  'normal': [
    'Periksa kadar gula darah secara rutin.',
    'Jaga pola makan sehat dengan mengurangi konsumsi gula dan karbohidrat sederhana.',
    'Lakukan olahraga teratur minimal 30 menit setiap hari.',
    'Kendalikan berat badan dengan diet seimbang.',
    'Hindari stres dan tidur yang cukup.',
  ],
  'diabetes': [
    'Periksa kadar gula darah secara rutin.',
    'Jaga pola makan sehat dengan mengurangi konsumsi gula dan karbohidrat sederhana.',
    'Lakukan olahraga teratur minimal 30 menit setiap hari.',
    'Kendalikan berat badan dengan diet seimbang.',
    'Hindari stres dan tidur yang cukup.',
  ],
  'pre-diabetes': [
    'Periksa kadar gula darah secara rutin.',
    'Jaga pola makan sehat dengan mengurangi konsumsi gula dan karbohidrat sederhana.',
    'Lakukan olahraga teratur minimal 30 menit setiap hari.',
    'Kendalikan berat badan dengan diet seimbang.',
    'Hindari stres dan tidur yang cukup.',
  ],
};
