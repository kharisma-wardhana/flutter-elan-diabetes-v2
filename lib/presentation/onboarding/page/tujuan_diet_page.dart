import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/service_locator.dart';
import '../../widget/custom_button.dart';

class TujuanDietPage extends StatelessWidget {
  final List<String> data;
  const TujuanDietPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('ELAN')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tujuan Diet',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                32.verticalSpace,
                ...data.map(
                  (item) => Text('- $item', style: TextStyle(fontSize: 18.sp)),
                ),
                16.verticalSpace,
                CustomButton(
                  textButton: "Lanjutkan",
                  onTap: () {
                    sl<AppNavigator>().pushNamed(kaloriIntakePage);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
