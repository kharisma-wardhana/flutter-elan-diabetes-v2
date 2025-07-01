import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendationPage extends StatelessWidget {
  final List<String> data;
  const RecommendationPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.r),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Text(
                    data[index],
                    style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
