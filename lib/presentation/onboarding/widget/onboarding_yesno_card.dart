import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingYesnoCard extends StatelessWidget {
  final String title;
  final String optionA;
  final String optionB;
  final VoidCallback? onTapA;
  final VoidCallback? onTapB;

  const OnboardingYesnoCard({
    super.key,
    required this.title,
    required this.optionA,
    required this.optionB,
    this.onTapA,
    this.onTapB,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Text(
            title,
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        16.verticalSpace,
        Expanded(
          child: ElevatedButton(
            onPressed: onTapA,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.r, horizontal: 8.r),
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Text(optionA),
          ),
        ),
        16.verticalSpace,
        Expanded(
          child: ElevatedButton(
            onPressed: onTapB,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.r, horizontal: 8.r),
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Text(optionB),
          ),
        ),
      ],
    );
  }
}
