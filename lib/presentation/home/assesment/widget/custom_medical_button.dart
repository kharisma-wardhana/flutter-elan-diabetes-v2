import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/colors.gen.dart';

class CustomMedicalButton extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final Color? color;
  final VoidCallback onTap;

  const CustomMedicalButton({
    super.key,
    required this.label,
    this.labelColor,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(150.w, 180.h), // Adjust size as needed
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: ColorName.secondary),
        ),
      ),
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: labelColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
