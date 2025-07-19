import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/constant.dart';
import '../../../../core/service_locator.dart';
import '../../../../gen/assets.gen.dart';
import '../../../widget/custom_loading.dart';
import '../article/cubit/article_cubit.dart';
import '../doctor/cubit/doctor_cubit.dart';
import '../video/cubit/video_cubit.dart';
import '../widget/custom_big_button.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final navigatorHelper = sl<AppNavigator>();
  static final ArticleCubit articleCubit = sl<ArticleCubit>();
  static final DoctorCubit doctorCubit = sl<DoctorCubit>();
  static final VideoCubit videoCubit = sl<VideoCubit>();
  bool isLoading = false;
  String? errorMessage;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                Text(
                  'INFORMASI',
                  style: GoogleFonts.poppins(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(),
                16.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: CustomBigButton(
                        icon: Assets.images.a13840231.path,
                        label: 'Ruang\nKonsultasi',
                        onTap: () async {
                          if (!mounted) return;
                          setState(() {
                            isLoading = true;
                            errorMessage = null;
                          });
                          try {
                            await doctorCubit.getAllDoctor();
                            if (!mounted) return;
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(doctorPage);
                          } catch (e) {
                            if (!mounted) return;
                            setState(() {
                              isLoading = false;
                              errorMessage = 'Gagal memuat data dokter';
                            });
                            _showErrorDialog('Gagal memuat data dokter');
                          }
                        },
                      ),
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: CustomBigButton(
                        icon: Assets.images.informasiDiabetes.path,
                        label: 'Informasi\nDiabetes',
                        onTap: () async {
                          if (!mounted) return;
                          setState(() {
                            isLoading = true;
                            errorMessage = null;
                          });
                          try {
                            await articleCubit.getAll();
                            if (!mounted) return;
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(articlePage);
                          } catch (e) {
                            if (!mounted) return;
                            setState(() {
                              isLoading = false;
                              errorMessage = 'Gagal memuat artikel';
                            });
                            _showErrorDialog('Gagal memuat artikel');
                          }
                        },
                      ),
                    ),
                  ],
                ),
                16.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: CustomBigButton(
                        icon: Assets.images.icon.path,
                        label: 'Video\nEdukasi',
                        onTap: () async {
                          if (!mounted) return;
                          setState(() {
                            isLoading = true;
                            errorMessage = null;
                          });
                          try {
                            await videoCubit.getAllVideo();
                            if (!mounted) return;
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(videoPage);
                          } catch (e) {
                            if (!mounted) return;
                            setState(() {
                              isLoading = false;
                              errorMessage = 'Gagal memuat video';
                            });
                            _showErrorDialog('Gagal memuat video');
                          }
                        },
                      ),
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: CustomBigButton(
                        icon: Assets.images.edukasiBencana.path,
                        label: 'Edukasi\nBencana',
                        onTap: () {
                          navigatorHelper.pushNamed(edukasiPage);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isLoading) Positioned.fill(child: CustomLoading()),
      ],
    );
  }
}
