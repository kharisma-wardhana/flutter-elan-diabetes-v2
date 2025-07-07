import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/service_locator.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../../widget/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    // Optionally, you can add any initialization logic here
  }

  @override
  void dispose() {
    isLoading = false;
    // Clean up any resources if needed
    super.dispose();
  }

  void _handleLogout() {
    setState(() {
      isLoading = true;
    });
    context.read<AuthBloc>().add(LogoutEvent());
    context.read<AuthBloc>().stream.listen((state) {
      if (state is AuthInitial) {
        sl<AppNavigator>().pushNamedAndRemoveUntil(loginPage);
      }
      if (state is AuthError) {
        Fluttertoast.showToast(
          msg: state.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome, ${state.userEntity.name}',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    20.verticalSpace,
                    Text(
                      'Mobile: ${state.userEntity.mobile}',
                      style: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.start,
                    ),
                    10.verticalSpace,
                    Text(
                      'Usia: ${state.userEntity.dob}',
                      style: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.start,
                    ),
                    10.verticalSpace,
                    Text(
                      'Jenis Kelamin: ${state.userEntity.gender}',
                      style: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.start,
                    ),
                    20.verticalSpace,
                    CustomButton(
                      isLoading: isLoading,
                      textButton: 'Logout',
                      onTap: _handleLogout,
                      buttonColor: Colors.red,
                      textColor: Colors.white,
                    ),
                  ],
                );
              }
              return Center(
                child: Text(
                  'You are not logged in',
                  style: TextStyle(fontSize: 18.sp),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
