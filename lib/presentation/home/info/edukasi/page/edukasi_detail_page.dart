import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EdukasiDetailPage extends StatelessWidget {
  final Map<String, dynamic> edukasiEntity;
  const EdukasiDetailPage({super.key, required this.edukasiEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(edukasiEntity['title']),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30.h,
            color: Colors.white,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: (edukasiEntity['image'] as List<String>)
            .map(
              (e) => InteractiveViewer(
                boundaryMargin: const EdgeInsets.all(20.0),
                minScale: 0.5,
                maxScale: 4.0,
                panEnabled: false,
                child: Image.asset(e, fit: BoxFit.fitWidth),
              ),
            )
            .toList(),
      ),
    );
  }
}
