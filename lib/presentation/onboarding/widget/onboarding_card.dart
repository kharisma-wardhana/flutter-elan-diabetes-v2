import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../../widget/custom_button.dart';

class OnboardingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final VoidCallback onTap;

  const OnboardingCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            Assets.images.logoKemenkes.path,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 300.h,
            child: Image.asset(Assets.images.logo.path, fit: BoxFit.contain),
          ),
        ),
        32.verticalSpace,
        SizedBox(
          height: 100.h,
          child: Image.asset(Assets.images.logoElan.path, fit: BoxFit.contain),
        ),
        32.verticalSpace,
        CustomButton(textButton: 'Lanjutkan', onTap: onTap),
      ],
    );
  }
}
