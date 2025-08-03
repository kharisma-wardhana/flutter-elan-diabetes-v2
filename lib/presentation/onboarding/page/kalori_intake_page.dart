import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/service_locator.dart';
import '../../widget/custom_button.dart';

class KaloriIntakePage extends StatelessWidget {
  final List<String> data;
  const KaloriIntakePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('KALORI INTAKE')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...data.map(
                (item) => Text('- $item', style: TextStyle(fontSize: 20.sp)),
              ),
              Spacer(),
              CustomButton(
                textButton: "Lanjutkan",
                onTap: () {
                  sl<AppNavigator>().pushNamed(dietPage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
