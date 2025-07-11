import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/service_locator.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class GulaDarahPage extends StatefulWidget {
  const GulaDarahPage({super.key});

  @override
  State<GulaDarahPage> createState() => _GulaDarahPageState();
}

class _GulaDarahPageState extends State<GulaDarahPage> {
  static final _formKey = GlobalKey<FormState>();
  bool isDiabetes = false;
  TextEditingController gulaDarahPuasaController = TextEditingController();
  TextEditingController gulaDarahSewaktuController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isDiabetes = false; // Initialize to false, change based on logic
  }

  @override
  void dispose() {
    isDiabetes = false; // Reset the state when disposing
    gulaDarahPuasaController.dispose();
    gulaDarahSewaktuController.dispose();
    super.dispose();
  }

  void checkGulaDarahPuasa(String val) {
    // Logic to check Gula Darah and navigate to the appropriate page
    // This is just a placeholder for the actual logic
    if (val.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Gula Darah Puasa tidak boleh kosong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void checkGulaDarahSewaktu(String val) {
    // Logic to check Gula Darah and navigate to the appropriate page
    // This is just a placeholder for the actual logic
    if (val.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Gula Darah Puasa tidak boleh kosong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void _handleNextButton() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    if (isDiabetes) {
      sl<AppNavigator>().pushNamedAndRemoveUntil(
        recommendationPage,
        arguments: recommendations['diabetes']!,
      );
      return;
    }
    sl<AppNavigator>().pushNamedAndRemoveUntil(
      recommendationPage,
      arguments: recommendations['normal']!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Gula Darah')),
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  labelText: 'Gula Darah Puasa',
                  hintText: 'Masukkan Gula Darah Puasa',
                  keyboardType: TextInputType.number,
                  onChanged: checkGulaDarahPuasa,
                  controller: gulaDarahPuasaController,
                  satuanText: 'mg/dL',
                  validatorEmpty: 'Gula Darah Puasa tidak boleh kosong',
                ),
                16.verticalSpace,
                CustomTextField(
                  labelText: 'Gula Darah Sewaktu',
                  hintText: 'Masukkan Gula Darah Sewaktu',
                  keyboardType: TextInputType.number,
                  onChanged: checkGulaDarahSewaktu,
                  controller: gulaDarahSewaktuController,
                  satuanText: 'mg/dL',
                  validatorEmpty: 'Gula Darah Sewaktu tidak boleh kosong',
                ),
                16.verticalSpace,
                CustomButton(textButton: "Lanjutkan", onTap: _handleNextButton),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
