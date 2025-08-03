import 'package:elan/core/constant.dart';
import 'package:elan/presentation/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_navigator.dart';
import '../../../core/service_locator.dart';

class RecommendationPage extends StatelessWidget {
  final List<String> data;
  const RecommendationPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('REKOMENDASI')),
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.r),
                      child: Text(
                        '- ${data[index]}',
                        style: TextStyle(fontSize: 22.sp),
                      ),
                    );
                  },
                ),
              ),
              CustomButton(
                textButton: "Lanjutkan",
                onTap: () {
                  sl<AppNavigator>().pushNamed(activityPage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
