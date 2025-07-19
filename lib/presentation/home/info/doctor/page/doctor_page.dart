import 'dart:io';

import 'package:elan/core/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../gen/colors.gen.dart';
import '../../../../widget/base_page.dart';
import '../../../../widget/custom_loading.dart';
import '../cubit/doctor_cubit.dart';
import '../cubit/doctor_state.dart';

class DoctorPage extends StatelessWidget {
  const DoctorPage({super.key});

  void _launch(String phone) async {
    String url =
        "https://api.whatsapp.com/send?phone=$phone=${Uri.parse("Halo, ")}";
    if (Platform.isAndroid) {
      url = "https://wa.me/$phone/?text=${Uri.parse("Halo, ")}";
    }
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(
        title: Text('Ruang Konsultasi'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30.h,
            color: Colors.white,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state.doctorState.status.isHasData) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const Text('Jadwal Konsultasi', textAlign: TextAlign.center),
                SizedBox(height: 8.h),
                const Text(
                  'Senin - Jumat | Jam 08:00 - 17:00',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                ...state.doctorState.data!.map(
                  (e) => Row(
                    children: [
                      SizedBox(
                        width: 80.w,
                        height: 100.h,
                        child: Image.network(e.image, fit: BoxFit.contain),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text(e.name), Text(e.position)],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _launch(e.mobile);
                        },
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 30.h,
                          color: ColorName.darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          if (state.doctorState.status.isError) {
            return const Center(
              child: Text('Something Went Wrong, Please Try Again Later'),
            );
          }
          return const CustomLoading();
        },
      ),
    );
  }
}
