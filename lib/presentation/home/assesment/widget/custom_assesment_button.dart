import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../gen/colors.gen.dart';

class CustomAssesmentButton extends StatelessWidget {
  final String title;
  final List<String> data;
  final Function onTap;

  const CustomAssesmentButton({
    super.key,
    required this.title,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              8.verticalSpace,
              InkWell(
                borderRadius: BorderRadius.circular(8.r),
                onTap: () => onTap(),
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: ColorName.primary, width: 2.w),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data
                        .map(
                          (text) =>
                              Text(text, style: TextStyle(fontSize: 16.sp)),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
