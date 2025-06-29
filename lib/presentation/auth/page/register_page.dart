import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/service_locator.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_dropdown.dart';
import '../../widget/custom_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController genderController = TextEditingController(
    text: 'Laki-laki',
  );
  final TextEditingController dobController = TextEditingController(
    text: 'Tanggal Lahir',
  );
  final TextEditingController mobileController = TextEditingController(
    text: '',
  );

  static final List<String> genderList = ['Laki-laki', 'Wanita'];

  DateTime selectedDate = DateTime.now();
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

    // Reset the password visibility state
    isLoading = false;
    isPasswordHidden = false;
    mobileController.dispose();
    nameController.dispose();

    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1940, 6, 12),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Container(child: child!);
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        dobController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      // Simulate a registration process
      setState(() {
        isLoading = true;
      });
      final email = '${mobileController.text}@email.com';
      context.read<AuthBloc>().add(
        RegisterEvent(
          name: nameController.text,
          email: email,
          mobile: mobileController.text,
          dob: dobController.text,
          gender: genderController.text,
        ),
      );
      context.read<AuthBloc>().stream.listen((state) {
        if (state is AuthSuccess) {
          // Show success message and navigate to home
          Fluttertoast.showToast(
            msg: 'Pendaftaran Berhasil',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.sp,
          );
          sl<AppNavigator>().pushReplacementNamed(onboardingPage);
        } else if (state is AuthError) {
          // Show error message
          Fluttertoast.showToast(
            msg: state.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.sp,
          );
        }
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget _buildFormRegister() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo dan form scrollable
        SizedBox(
          width: 200.w,
          child: Image.asset(Assets.images.logoElan.path, fit: BoxFit.cover),
        ),
        32.verticalSpace,
        Text(
          "Pendaftaran Pengguna",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        16.verticalSpace,
        Text(
          "Silahkan Lakukan Pengisian Data!",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        32.verticalSpace,
        CustomTextField(
          labelText: 'Nama Lengkap',
          hintText: 'Masukkan Nama Lengkap',
          controller: nameController,
          keyboardType: TextInputType.name,
          validatorEmpty: 'Silahkan masukkan nama lengkap Anda',
        ),
        16.verticalSpace,
        CustomTextField(
          labelText: 'Nomor Handphone',
          hintText: 'Masukkan Handphone',
          controller: mobileController,
          keyboardType: TextInputType.phone,
          validatorEmpty: 'Silahkan masukkan nomor handphone Anda',
        ),
        16.verticalSpace,
        CustomDropdown(
          controller: genderController,
          items: genderList,
          onChanged: (value) {
            setState(() => genderController.text = value.toString());
          },
        ),
        16.verticalSpace,
        InkWell(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: 70.h,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: ColorName.darkGrey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [Text(dobController.text, textAlign: TextAlign.start)],
            ),
          ),
          onTap: () {
            _selectDate(context);
          },
        ),
        16.verticalSpace,
        BlocSelector<AuthBloc, AuthState, bool>(
          selector: (state) {
            if (state is AuthLoading) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            return CustomButton(
              textButton: 'Daftar',
              isLoading: isLoading,
              onTap: isLoading ? null : _handleRegister,
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: Stack(
            children: [
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
                        child: _buildFormRegister(),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.close, size: 60.w),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
