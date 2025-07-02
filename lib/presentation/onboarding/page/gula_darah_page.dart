import 'package:elan/core/constant.dart';
import 'package:elan/presentation/widget/custom_button.dart';
import 'package:elan/presentation/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_navigator.dart';
import '../../../core/service_locator.dart';

class GulaDarahPage extends StatefulWidget {
  const GulaDarahPage({super.key});

  @override
  State<GulaDarahPage> createState() => _GulaDarahPageState();
}

class _GulaDarahPageState extends State<GulaDarahPage> {
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
  }

  void checkGulaDarahSewaktu(String val) {
    // Logic to check Gula Darah and navigate to the appropriate page
    // This is just a placeholder for the actual logic
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Gula Darah')),
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                hintText: 'Masukkan Gula Darah Puasa',
                keyboardType: TextInputType.number,
                onChanged: checkGulaDarahPuasa,
                controller: gulaDarahPuasaController,
                satuanText: 'mg/dL',
              ),
              16.verticalSpace,
              CustomTextField(
                hintText: 'Masukkan Gula Darah 2 Jam Setelah Makan',
                keyboardType: TextInputType.number,
                onChanged: checkGulaDarahSewaktu,
                controller: gulaDarahSewaktuController,
                satuanText: 'mg/dL',
              ),
              16.verticalSpace,
              CustomButton(
                textButton: "Lanjutkan",
                onTap: () {
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
