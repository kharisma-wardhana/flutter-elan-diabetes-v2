import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/service_locator.dart';
import '../../widget/custom_button.dart';

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Perencanaan Diet')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(bottom: 8.r),
                  children: [
                    Text(
                      'Perencanaan Diet',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    16.verticalSpace,
                    Text(
                      'Berikut adalah beberapa tips untuk perencanaan diet yang sehat:',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    8.verticalSpace,
                    Text('- Konsumsi makanan seimbang'),
                    Text('- Perbanyak sayur dan buah'),
                    Text('- Batasi gula dan garam'),
                    Text('- Minum cukup air'),
                  ],
                ),
              ),
              CustomButton(
                textButton: "Lanjutkan",
                onTap: () {
                  sl<AppNavigator>().pushNamed(homePage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
