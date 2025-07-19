import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widget/custom_button.dart';

class CustomEmptyData extends StatelessWidget {
  final String text;
  final String routePage;

  const CustomEmptyData({
    super.key,
    required this.text,
    required this.routePage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(Icons.assignment, size: 180.h, color: Colors.green),
          SizedBox(height: 20.h),
          Text(
            'Riwayat $text tidak ditemukan',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          Text(
            'Silahkan menambahkan daftar $text',
            style: TextStyle(fontSize: 18.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          CustomButton(
            textButton: 'Tambahkan',
            onTap: () {
              Navigator.pushNamed(context, routePage);
            },
          ),
        ],
      ),
    );
  }
}
