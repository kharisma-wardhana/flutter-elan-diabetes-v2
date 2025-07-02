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
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          64.verticalSpace,
          _buildOptionButton(text: optionA, onTap: onTapA),
          32.verticalSpace,
          _buildOptionButton(text: optionB, onTap: onTapB),
        ],
      ),
    );
  }

  Widget _buildOptionButton({required String text, VoidCallback? onTap}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.r),
          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        child: Text(text),
      ),
    );
  }
}
