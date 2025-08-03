import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/service_locator.dart';
import '../../widget/custom_button.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_state.dart';

class TujuanDietPage extends StatelessWidget {
  final List<String> data;
  const TujuanDietPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('TUJUAN DIET')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(bottom: 8.r),
                  children: [
                    ...data.map(
                      (item) =>
                          Text('- $item', style: TextStyle(fontSize: 24.sp)),
                    ),
                  ],
                ),
              ),
              CustomButton(
                textButton: "Lanjutkan",
                onTap: () {
                  sl<AppNavigator>().pushNamed(
                    kaloriIntakePage,
                    arguments:
                        (context.read<OnboardingBloc>().state
                            is OnboardingSuccessDiabetes)
                        ? dataKaloriIntake['DM']
                        : dataKaloriIntake['Normal'],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
