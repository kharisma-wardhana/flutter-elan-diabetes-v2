import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/service_locator.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_dropdown.dart';

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  TextEditingController karbohidratController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController seratController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Perencanaan Diet')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(bottom: 8.r),
                  children: [
                    Text(
                      'Karbohidrat',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    8.verticalSpace,
                    CustomDropdown(
                      controller: karbohidratController,
                      items: karboOptions,
                      onChanged: (val) {
                        karbohidratController.text = val;
                      },
                    ),
                    16.verticalSpace,
                    Text(
                      'Protein dan Lemak Sehat',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    8.verticalSpace,
                    CustomDropdown(
                      controller: proteinController,
                      items: proteinOptions,
                      onChanged: (val) {
                        proteinController.text = val;
                      },
                    ),
                    16.verticalSpace,
                    Text(
                      'Serat',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    8.verticalSpace,
                    CustomDropdown(
                      controller: seratController,
                      items: seratOptions,
                      onChanged: (val) {
                        seratController.text = val;
                      },
                    ),
                    16.verticalSpace,
                  ],
                ),
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder:(context, state) {
                  if (state is AuthSuccess) {
                    if (state.userEntity.isOnboardingComplete != null
                        && state.userEntity.isOnboardingComplete!) {
                      sl<AppNavigator>().pushNamedAndRemoveUntil(homePage);
                    }
                  }
                  return CustomButton(
                    textButton: "Lanjutkan",
                    onTap: () {
                      context.read<AuthBloc>().add(CompleteOnboardingEvent());
                    },
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
