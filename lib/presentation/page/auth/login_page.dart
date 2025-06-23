import 'package:elan_diabetes/presentation/bloc/auth/auth_bloc.dart';
import 'package:elan_diabetes/presentation/bloc/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/service_locator.dart';
import '../../../gen/assets.gen.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_loading.dart';
import '../../widget/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController mobileController = TextEditingController(
    text: '',
  );
  final TextEditingController passwordController = TextEditingController(
    text: '',
  );
  static final _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Reset the form and controllers when disposing
    _formKey.currentState?.reset();
    mobileController.clear();
    passwordController.clear();
    // Reset the password visibility state
    isLoading = false;
    isPasswordHidden = false;
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      print("CALL LOGIN");
      sl<AuthBloc>().add(
        LoginEvent(
          username: mobileController.text,
          password: passwordController.text,
        ),
      );
    }
  }

  Widget _buildFormLogin() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo dan form scrollable
        Flexible(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                80.verticalSpace,
                SizedBox(
                  width: 200.w,
                  child: Image.asset(
                    Assets.images.logoElan.path,
                    fit: BoxFit.cover,
                  ),
                ),
                32.verticalSpace,
                CustomTextField(
                  labelText: 'Nomor Handphone',
                  hintText: 'Masukkan Handphone',
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  validatorEmpty: 'Silahkan masukkan nomor handphone Anda',
                ),
                32.verticalSpace,
                CustomTextField(
                  labelText: 'Tanggal Lahir',
                  hintText: 'Tanggal Lahir (dd-mm-yyyy)',
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validatorEmpty: 'Silahkan masukkan tanggal lahir Anda',
                  obscureText: isPasswordHidden,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20.sp,
                    ),
                    onPressed: () => setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    }),
                  ),
                ),
                BlocSelector<AuthBloc, AuthState, String?>(
                  selector: (state) {
                    if (state is AuthError) {
                      return state.message;
                    }
                    return null;
                  },
                  builder: (context, message) {
                    return message != null
                        ? Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              message,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
        24.verticalSpace,
        // CustomButton(
        //   textButton: 'Masuk',
        //   onTap: isLoading ? null : _handleLogin,
        // ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              isLoading = true;
            });
            final username = mobileController.text.trim();
            final password = passwordController.text.trim();
            sl<AuthBloc>().add(
              AuthEvent.login(username: username, password: password),
            );
            sl<AuthBloc>().stream.listen((state) {
              if (state is AuthSuccess) {
                setState(() {
                  isLoading = false;
                });
                // Navigate to the next page or show success message
              } else if (state is AuthError) {
                setState(() {
                  isLoading = false;
                });
                // Show error message
                Fluttertoast.showToast(
                  msg: state.message,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                );
              }
            });
          },
          child: Text('Masuk'),
        ),
        10.verticalSpace,
        // Register
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum punya Akun?',
              style: TextStyle(fontSize: 14.sp, color: Colors.black54),
            ),
            TextButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      _formKey.currentState?.reset();
                      mobileController.clear();
                      passwordController.clear();
                    },
              child: Text(
                'Buat Akun',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 60,
                  child: Image.asset(
                    Assets.images.side.path,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16.0.r),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 400.w,
                        minWidth: 200.w,
                      ),
                      child: _buildFormLogin(),
                    ),
                  ),
                ),
              ),
              if (isLoading) const CustomLoading(),
            ],
          ),
        ),
      ),
    );
  }
}
