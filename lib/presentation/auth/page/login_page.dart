import 'package:elan/presentation/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/service_locator.dart';
import '../../../gen/assets.gen.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController mobileController = TextEditingController(
    text: '', // Example phone number
  );
  final TextEditingController passwordController = TextEditingController(
    text: '',
  );
  final _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mobileController.clear();
    passwordController.clear();
    // Reset the password visibility state
    isPasswordHidden = false;
    isLoading = false;
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
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
        SizedBox(
          width: 200.w,
          child: Image.asset(Assets.images.logoElan.path, fit: BoxFit.cover),
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
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          validatorEmpty: 'Silahkan masukkan tanggal lahir Anda',
          obscureText: isPasswordHidden,
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordHidden
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 28.sp,
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
          builder: (context, message) => message != null
              ? Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        24.verticalSpace,
        BlocSelector<AuthBloc, AuthState, bool>(
          selector: (state) {
            if (state is AuthLoading) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            bool isLoadingButton = state;
            return CustomButton(
              textButton: 'Masuk',
              onTap: isLoadingButton ? null : _handleLogin,
            );
          },
        ),
        16.verticalSpace,
        // Register
        Text(
          'Belum punya Akun?',
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        TextButton(
          onPressed: isLoading
              ? null
              : () {
                  _formKey.currentState?.reset();
                  mobileController.clear();
                  passwordController.clear();
                  sl<AppNavigator>().pushNamed(registerPage);
                },
          child: Text(
            'Buat Akun'.toUpperCase(),
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.blue[700],
              decoration: TextDecoration.underline,
            ),
            textAlign: TextAlign.center,
          ),
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
              Positioned(
                child: SizedBox(
                  child: Image.asset(
                    Assets.images.side.path,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 400.w,
                          minWidth: 200.w,
                        ),
                        child: BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthLoading) {
                              setState(() => isLoading = true);
                            } else if (state is AuthSuccess) {
                              setState(() => isLoading = false);
                              sl<AppNavigator>().pushNamedAndRemoveUntil(
                                onboardingPage,
                              );
                            } else if (state is AuthError) {
                              setState(() => isLoading = false);
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
                          child: _buildFormLogin(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (isLoading) Positioned.fill(child: const CustomLoading()),
            ],
          ),
        ),
      ),
    );
  }
}
