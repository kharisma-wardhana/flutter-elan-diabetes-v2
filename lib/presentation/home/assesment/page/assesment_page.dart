import 'package:elan/core/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/constant.dart';
import '../../../../core/service_locator.dart';
import '../../../widget/custom_loading.dart';
import '../bloc/asam_urat/asam_urat_cubit.dart';
import '../bloc/assesment/assesment_cubit.dart';
import '../bloc/assesment/assesment_state.dart';
import '../bloc/ginjal/ginjal_cubit.dart';
import '../bloc/gula_darah/gula_cubit.dart';
import '../bloc/hb1ac/hb1ac_cubit.dart';
import '../bloc/kolesterol/kolesterol_cubit.dart';
import '../bloc/tekanan_darah/tensi_cubit.dart';
import '../bloc/water/water_cubit.dart';
import '../widget/custom_assesment_button.dart';

class AssesmentPage extends StatefulWidget {
  const AssesmentPage({super.key});

  @override
  State<AssesmentPage> createState() => _AssesmentPageState();
}

class _AssesmentPageState extends State<AssesmentPage> {
  bool isLoading = false;
  static final navigatorHelper = sl<AppNavigator>();
  static final dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: BlocConsumer<AssesmentCubit, AssesmentState>(
                listener: (context, state) {
                  if (state.assesmentState.status.isLoading) {
                    setState(() => isLoading = true);
                  } else if (state.assesmentState.status.isError ||
                      state.assesmentState.status.isHasData) {
                    setState(() => isLoading = false);
                  }
                },
                builder: (context, state) {
                  if (state.assesmentState.status.isHasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        CustomAssesmentButton(
                          title: 'Kadar Gula Darah',
                          data: [
                            'Total: ${state.assesmentState.data!.gula?.total}',
                            state.assesmentState.data!.gula?.type == 1
                                ? 'Jenis: Puasa'
                                : 'Jenis: Non Puasa',
                            'Tanggal: ${state.assesmentState.data!.gula?.date}',
                          ],
                          onTap: () async {
                            setState(() => isLoading = true);
                            await context.read<GulaCubit>().getListGula(
                              dateNow,
                            );
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(gulaPage);
                          },
                        ),
                        8.verticalSpace,
                        CustomAssesmentButton(
                          title: 'Tekanan Darah',
                          data: state.assesmentState.data!.tensi == null
                              ? [
                                  'Belum ada data tekanan darah',
                                  'Silakan cek tekanan darah Anda terlebih dahulu.',
                                ]
                              : [
                                  'Tensi: ${state.assesmentState.data!.tensi?.sistole} / ${state.assesmentState.data!.tensi?.diastole}',
                                  'Tanggal: ${state.assesmentState.data!.tensi?.date}',
                                ],
                          onTap: () async {
                            setState(() => isLoading = true);
                            await context.read<TensiCubit>().getListTensi(
                              dateNow,
                            );
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(tensiPage);
                          },
                        ),
                        8.verticalSpace,
                        CustomAssesmentButton(
                          title: 'HbA1c',
                          data: state.assesmentState.data!.hb1ac == null
                              ? [
                                  'Belum ada data HbA1c',
                                  'Silakan cek HbA1c Anda terlebih dahulu.',
                                ]
                              : [
                                  'Total: ${state.assesmentState.data!.hb1ac?.total}',
                                  'Tanggal: ${state.assesmentState.data!.hb1ac?.date}',
                                ],
                          onTap: () async {
                            setState(() => isLoading = true);
                            await context.read<Hb1acCubit>().getListHb(dateNow);
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(hbPage);
                          },
                        ),
                        8.verticalSpace,
                        CustomAssesmentButton(
                          title: 'Konsumsi Air',
                          data: state.assesmentState.data!.water == null
                              ? [
                                  'Belum ada data konsumsi air',
                                  'Silakan cek konsumsi air Anda terlebih dahulu.',
                                ]
                              : [
                                  'Total: ${state.assesmentState.data!.water?.total}',
                                  'Target: ${state.assesmentState.data!.water?.target}',
                                  'Tanggal: ${state.assesmentState.data!.water?.date}',
                                ],
                          onTap: () async {
                            setState(() => isLoading = true);
                            await context.read<WaterCubit>().getAllWater(
                              dateNow,
                            );
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(waterPage);
                          },
                        ),
                        CustomAssesmentButton(
                          title: 'Asam Urat',
                          data: state.assesmentState.data!.asamUrat == null
                              ? [
                                  'Belum ada data asam urat',
                                  'Silakan cek asam urat Anda terlebih dahulu.',
                                ]
                              : [
                                  'Total: ${state.assesmentState.data!.asamUrat?.total}',
                                  'Tanggal: ${state.assesmentState.data!.asamUrat?.date}',
                                ],
                          onTap: () async {
                            setState(() => isLoading = true);
                            await context.read<AsamUratCubit>().getListAsamUrat(
                              dateNow,
                            );
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(asamUratPage);
                          },
                        ),
                        8.verticalSpace,
                        CustomAssesmentButton(
                          title: 'Kadar Kolesterol',
                          data: state.assesmentState.data!.kolesterol == null
                              ? [
                                  'Belum ada data kolesterol',
                                  'Silakan cek kadar kolesterol Anda terlebih dahulu.',
                                ]
                              : [
                                  'Total: ${state.assesmentState.data!.kolesterol?.total}',
                                  'Jenis: ${state.assesmentState.data!.kolesterol?.type}',
                                  'Tanggal: ${state.assesmentState.data!.kolesterol?.date}',
                                ],
                          onTap: () async {
                            setState(() => isLoading = true);
                            await context
                                .read<KolesterolCubit>()
                                .getListKolesterol(dateNow);
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(kolesterolPage);
                          },
                        ),
                        8.verticalSpace,
                        CustomAssesmentButton(
                          title: 'Check Ureum & Kreatinin',
                          data: state.assesmentState.data!.ginjal == null
                              ? [
                                  'Belum ada data ginjal',
                                  'Silakan cek kesehatan ginjal Anda terlebih dahulu.',
                                ]
                              : [
                                  'Total: ${state.assesmentState.data!.ginjal?.total}',
                                  state.assesmentState.data!.ginjal?.type == 1
                                      ? 'Jenis: Ureum'
                                      : 'Jenis: Kreatinin',
                                  'Tanggal: ${state.assesmentState.data!.ginjal?.date}',
                                ],
                          onTap: () async {
                            setState(() => isLoading = true);
                            await context.read<GinjalCubit>().getListGinjal(
                              dateNow,
                            );
                            setState(() => isLoading = false);
                            navigatorHelper.pushNamed(ginjalPage);
                          },
                        ),
                        16.verticalSpace,
                      ],
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
            if (isLoading) Positioned.fill(child: const CustomLoading()),
          ],
        ),
      ),
    );
  }
}
