import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../widget/custom_dropdown.dart';
import '../../widget/custom_text_field.dart';

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
                  icon: const Icon(Icons.close, size: 60),
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
