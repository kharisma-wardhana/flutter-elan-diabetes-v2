import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/service_locator.dart';
import '../../../gen/assets.gen.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Check if the user has completed onboarding
          if (state.userEntity.isOnboardingComplete != null &&
              state.userEntity.isOnboardingComplete!) {
            if (state.userEntity.isAntropometriComplete != null &&
                state.userEntity.isAntropometriComplete!) {
              // Navigate to home page if antropometri is complete
              sl<AppNavigator>().pushNamedAndRemoveUntil(homePage);
            } else {
              sl<AppNavigator>().pushNamedAndRemoveUntil(antropometriPage);
            }
          } else {
            sl<AppNavigator>().pushNamedAndRemoveUntil(onboardingPage);
          }
        } else if (state is AuthInitial) {
          sl<AppNavigator>().pushNamedAndRemoveUntil(loginPage);
        } else if (state is AuthError) {
          sl<AppNavigator>().pushNamedAndRemoveUntil(loginPage);
          Fluttertoast.showToast(
            msg: state.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18.sp,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300.w, // Responsive width
                      child: Image.asset(
                        Assets.images.logoKemenkes.path,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 300.h, // Responsive height
                      child: Image.asset(
                        Assets.images.logo.path,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100.h, // Responsive height
                      child: Image.asset(
                        Assets.images.logoElan.path,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
