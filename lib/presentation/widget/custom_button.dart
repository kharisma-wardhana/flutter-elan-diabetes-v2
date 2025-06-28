import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/colors.gen.dart';

class CustomButton extends StatelessWidget {
  final String textButton;
  final Color buttonColor;
  final Color textColor;
  final BorderRadiusGeometry buttonBorderRadius;
  final GestureTapCallback? onTap;
  final Icon? icon;
  final bool isOutlineButton;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.textButton,
    this.buttonColor = ColorName.primary,
    this.textColor = ColorName.white,
    this.buttonBorderRadius = const BorderRadius.all(Radius.circular(16)),
    this.onTap,
    this.icon,
    this.isOutlineButton = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: buttonBorderRadius,
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              color: Color.fromARGB(38, 75, 57, 239),
              offset: Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: isOutlineButton ? ColorName.primary : Colors.transparent,
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: ColorName.white)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon != null
                      ? Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: icon,
                        )
                      : const SizedBox(),
                  Expanded(
                    child: Text(
                      textButton.toUpperCase(),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
