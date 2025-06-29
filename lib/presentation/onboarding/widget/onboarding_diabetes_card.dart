import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../widget/custom_button.dart';

class OnboardDiabetesCard extends StatelessWidget {
  final String title;
  final String optionA;
  final String optionB;
  final String image;
  final String infoA;
  final String infoB;
  final VoidCallback onTapA;
  final VoidCallback? onTapB;

  const OnboardDiabetesCard({
    super.key,
    required this.title,
    required this.optionA,
    required this.optionB,
    required this.image,
    required this.onTapA,
    this.onTapB,
    required this.infoA,
    required this.infoB,
  });

  void _showModalBottomSheet(BuildContext context, String info, String data) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.sizeOf(context).height * 0.8,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(16.0.r),
          child: ListView(
            children: <Widget>[
              Text(
                info.toUpperCase(),
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Divider(color: ColorName.darkGrey, thickness: 1.5, height: 16.h),
              16.verticalSpace,
              Text(
                data,
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(Assets.images.border.path, fit: BoxFit.fill),
          ),
          32.verticalSpace,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(image, fit: BoxFit.contain),
          ),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              fontSize: 38.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(textButton: optionA, onTap: onTapA),
              ),
              8.horizontalSpace,
              InkWell(
                onTap: () {
                  _showModalBottomSheet(context, optionA, infoA);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorName.lightGrey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.question_mark_rounded,
                    size: 50.w,
                    color: ColorName.darkGrey,
                  ),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(
                  textButton: optionB,
                  onTap: onTapB ?? onTapA,
                ),
              ),
              8.horizontalSpace,
              InkWell(
                onTap: () {
                  _showModalBottomSheet(context, optionB, infoB);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorName.lightGrey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.question_mark_rounded,
                    size: 50.w,
                    color: ColorName.darkGrey,
                  ),
                ),
              ),
            ],
          ),
          32.verticalSpace,
        ],
      ),
    );
  }
}
