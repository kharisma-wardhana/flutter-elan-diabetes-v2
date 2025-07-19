import 'package:elan/presentation/home/info/edukasi/page/edukasi_detail_page.dart';
import 'package:elan/presentation/home/info/edukasi/page/edukasi_page.dart';
import 'package:elan/presentation/home/info/video/page/video_page.dart';
import 'package:elan/presentation/home/profile/page/about_page.dart';
import 'package:elan/presentation/onboarding/page/activity_page.dart';
import 'package:flutter/material.dart';

import '../presentation/auth/page/login_page.dart';
import '../presentation/auth/page/register_page.dart';
import '../presentation/home/assesment/page/antropometri/antropometri_page.dart';
import '../presentation/home/assesment/page/asam_urat/add_asam_urat_page.dart';
import '../presentation/home/assesment/page/asam_urat/asam_urat_page.dart';
import '../presentation/home/assesment/page/ginjal/add_ginjal_page.dart';
import '../presentation/home/assesment/page/ginjal/ginjal_page.dart';
import '../presentation/home/assesment/page/gula_darah/add_gula_page.dart';
import '../presentation/home/assesment/page/gula_darah/gula_page.dart';
import '../presentation/home/assesment/page/hb/add_hb_page.dart';
import '../presentation/home/assesment/page/hb/hb_page.dart';
import '../presentation/home/assesment/page/kolesterol/add_kolesterol_page.dart';
import '../presentation/home/assesment/page/kolesterol/kolesterol_page.dart';
import '../presentation/home/assesment/page/konsumsi_air/add_konsumsi_air_page.dart';
import '../presentation/home/assesment/page/konsumsi_air/konsumsi_air_page.dart';
import '../presentation/home/assesment/page/tekanan_darah/add_tensi_page.dart';
import '../presentation/home/assesment/page/tekanan_darah/tensi_page.dart';
import '../presentation/home/home_page.dart';
import '../presentation/home/info/article/page/detail_article_page.dart';
import '../presentation/home/info/article/page/list_article_page.dart';
import '../presentation/home/info/doctor/page/doctor_page.dart';
import '../presentation/onboarding/page/gula_darah_page.dart';
import '../presentation/onboarding/page/onboarding_page.dart';
import '../presentation/onboarding/page/recommendation_page.dart';
import '../presentation/home/profile/page/profile_page.dart';
import '../presentation/splash/page/splash_page.dart';

const String baseURL = 'https://elan.cmutiah.com/api';
const String tokenKey = 'auth_token';
const String userIDKey = 'user_id';

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

const String aboutPage = '/about';
const String articlePage = '/articles';
const String detailArticlePage = '/articles/detail';
const String edukasiPage = '/edukasi';
const String edukasiDetailPage = '/edukasi/detail';
const String doctorPage = '/doctors';
const String nutrisiPage = '/nutrisi';
const String addNutrisiPage = '/nutrisi/add';
const String obatPage = '/obat';
const String addObatPage = '/obat/add';
const String videoPage = '/video';

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
      case antropometriPage:
        return MaterialPageRoute(builder: (_) => const AntropometriPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case aboutPage:
        return MaterialPageRoute(builder: (_) => const AboutPage());
      case articlePage:
        return MaterialPageRoute(builder: (_) => const ListArticlePage());
      case detailArticlePage:
        return MaterialPageRoute(
          builder: (_) => DetailArticlePage(articleEntity: argument),
        );
      case videoPage:
        return MaterialPageRoute(builder: (_) => const VideoPage());
      case edukasiPage:
        return MaterialPageRoute(builder: (_) => const EdukasiPage());
      case edukasiDetailPage:
        return MaterialPageRoute(
          builder: (_) => EdukasiDetailPage(edukasiEntity: argument),
        );
      case doctorPage:
        return MaterialPageRoute(builder: (_) => const DoctorPage());
      // Assesment Pages
      case waterPage:
        return MaterialPageRoute(builder: (_) => const KonsumsiAirPage());
      case addWaterPage:
        return MaterialPageRoute(builder: (_) => const AddKonsumsiAirPage());
      case ginjalPage:
        return MaterialPageRoute(builder: (_) => const GinjalPage());
      case addGinjalPage:
        return MaterialPageRoute(builder: (_) => const AddGinjalPage());
      case gulaPage:
        return MaterialPageRoute(builder: (_) => const GulaPage());
      case addGulaPage:
        return MaterialPageRoute(builder: (_) => const AddGulaPage());
      case kolesterolPage:
        return MaterialPageRoute(builder: (_) => const KolesterolPage());
      case addKolesterolPage:
        return MaterialPageRoute(builder: (_) => const AddKolesterolPage());
      case tensiPage:
        return MaterialPageRoute(builder: (_) => const TensiPage());
      case addTensiPage:
        return MaterialPageRoute(builder: (_) => const AddTensiPage());
      case asamUratPage:
        return MaterialPageRoute(builder: (_) => const AsamUratPage());
      case addAsamUratPage:
        return MaterialPageRoute(builder: (_) => const AddAsamUratPage());
      case hbPage:
        return MaterialPageRoute(builder: (_) => const HbPage());
      case addHbPage:
        return MaterialPageRoute(builder: (_) => const AddHbPage());
      //============================================================
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

List<DropdownMenuEntry<String>> activityOptions = [
  DropdownMenuEntry<String>(value: 'Berjalan', label: 'Berjalan'),
  DropdownMenuEntry<String>(value: 'Senam', label: 'Senam'),
  DropdownMenuEntry<String>(value: 'Bersepeda', label: 'Bersepeda'),
  DropdownMenuEntry<String>(value: 'Berenang', label: 'Berenang'),
  DropdownMenuEntry<String>(value: 'Angkat Beban', label: 'Angkat Beban'),
  DropdownMenuEntry<String>(value: 'Lainnya', label: 'Lainnya'),
];

const int diabatesDM = 1;
const int diabetesPreDM = 2;
