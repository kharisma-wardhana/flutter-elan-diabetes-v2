import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/constant.dart';
import '../../../../core/service_locator.dart';
import '../../../widget/custom_loading.dart';
import '../bloc/activity/activity_cubit.dart';
import '../bloc/asam_urat/asam_urat_cubit.dart';
import '../bloc/ginjal/ginjal_cubit.dart';
import '../bloc/gula_darah/gula_cubit.dart';
import '../bloc/hb1ac/hb1ac_cubit.dart';
import '../bloc/kolesterol/kolesterol_cubit.dart';
import '../bloc/tekanan_darah/tensi_cubit.dart';
import '../bloc/water/water_cubit.dart';
import '../widget/custom_medical_button.dart';

class AssesmentPage extends StatefulWidget {
  const AssesmentPage({super.key});

  @override
  State<AssesmentPage> createState() => _AssesmentPageState();
}

class _AssesmentPageState extends State<AssesmentPage> {
  bool isLoading = false;
  static final navigatorHelper = sl<AppNavigator>();
  static final activityCubit = sl<ActivityCubit>();
  static final gulaCubit = sl<GulaCubit>();
  static final tensiCubit = sl<TensiCubit>();
  static final kolesterolCubit = sl<KolesterolCubit>();
  static final hb1acCubit = sl<Hb1acCubit>();
  static final asamUratCubit = sl<AsamUratCubit>();
  static final waterCubit = sl<WaterCubit>();
  static final ginjalCubit = sl<GinjalCubit>();
  static final dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CHECK KESEHATAN',
                    style: GoogleFonts.poppins(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  16.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomMedicalButton(
                          label: 'Kadar Gula Darah',
                          onTap: () async {
                            setState(() => isLoading = true);
                            await gulaCubit.getListGula(dateNow);
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(gulaPage);
                          },
                        ),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: CustomMedicalButton(
                          label: 'Tekanan Darah',
                          onTap: () async {
                            setState(() => isLoading = true);
                            await tensiCubit.getListTensi(dateNow);
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(tensiPage);
                          },
                        ),
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: CustomMedicalButton(
                          label: 'HbA1c',
                          onTap: () async {
                            setState(() => isLoading = true);
                            await hb1acCubit.getListHb(dateNow);
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(hbPage);
                          },
                        ),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: CustomMedicalButton(
                          label: 'Konsumsi Air',
                          onTap: () async {
                            setState(() => isLoading = true);
                            await waterCubit.getAllWater(dateNow);
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(waterPage);
                          },
                        ),
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: CustomMedicalButton(
                          label: 'Aktivitas',
                          onTap: () async {
                            setState(() => isLoading = true);
                            await activityCubit.getAllActivity(dateNow);
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(aktifitasPage);
                          },
                        ),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: CustomMedicalButton(
                          label: 'Kolesterol',
                          onTap: () async {
                            setState(() => isLoading = true);
                            await kolesterolCubit.getListKolesterol(dateNow);
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(kolesterolPage);
                          },
                        ),
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: CustomMedicalButton(
                          label: 'Asam Urat',
                          onTap: () async {
                            setState(() => isLoading = true);
                            await asamUratCubit.getListAsamUrat(dateNow);
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(asamUratPage);
                          },
                        ),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: CustomMedicalButton(
                          label: 'Cek Ureum & Kreatinin',
                          onTap: () async {
                            setState(() => isLoading = true);
                            await ginjalCubit.getListGinjal(dateNow);
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(ginjalPage);
                          },
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,
                ],
              ),
            ),
            if (isLoading) Positioned.fill(child: const CustomLoading()),
          ],
        ),
      ),
    );
  }
}
