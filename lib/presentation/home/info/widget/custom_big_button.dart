import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/colors.gen.dart';

class CustomBigButton extends StatelessWidget {
  final String icon;
  final String label;
  final Color? labelColor;
  final Color? color;
  final VoidCallback onTap;

  const CustomBigButton({
    super.key,
    this.color = ColorName.primary,
    this.labelColor = ColorName.white,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(150.w, 180.h), // Adjust size as needed
        padding: EdgeInsets.all(8.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
          side: const BorderSide(color: ColorName.secondary),
        ),
      ),
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          16.verticalSpace,
          SizedBox(child: Image.asset(icon, fit: BoxFit.contain)),
          16.verticalSpace,
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: labelColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
