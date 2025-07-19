import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_navigator.dart';
import '../../../../core/constant.dart';
import '../../../../core/service_locator.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../../auth/bloc/auth_event.dart';
import '../../../auth/bloc/auth_state.dart';
import '../../../widget/custom_button.dart';
import '../widget/profil_data.dart';

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
    context.read<AuthBloc>().add(LogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
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
        },
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'PROFIL PENGGUNA',
                  style: GoogleFonts.poppins(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(),
                ProfilData(title: "Nama", content: state.userEntity.name),
                ProfilData(
                  title: "Jenis Kelamin",
                  content: state.userEntity.gender,
                ),
                ProfilData(
                  title: "Tanggal Lahir",
                  content: state.userEntity.dob,
                ),
                ProfilData(
                  title: "No Handphone",
                  content: state.userEntity.mobile,
                ),
                Spacer(),
                CustomButton(
                  textButton: 'Profil Kesehatan',
                  onTap: () async {
                    sl<AppNavigator>().pushNamed(antropometriPage);
                  },
                ),
                16.verticalSpace,
                CustomButton(
                  textButton: 'Tentang Applikasi',
                  onTap: () {
                    sl<AppNavigator>().pushNamed(aboutPage);
                  },
                ),
                16.verticalSpace,
                CustomButton(
                  isLoading: isLoading,
                  textButton: 'Keluar',
                  onTap: _handleLogout,
                  buttonColor: Colors.red,
                  textColor: Colors.white,
                ),
              ],
            );
          }
          return Center(
            child: Text(
              'No user data available',
              style: TextStyle(fontSize: 16.sp),
            ),
          );
        },
      ),
    );
  }
}
