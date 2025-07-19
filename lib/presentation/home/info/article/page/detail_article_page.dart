import 'package:elan/core/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/service_locator.dart';
import '../../../../../domain/entities/article_entity.dart';

class DetailArticlePage extends StatelessWidget {
  final ArticleEntity articleEntity;
  DetailArticlePage({super.key, required this.articleEntity});

  final navigatorHelper = sl<AppNavigator>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Diabetes'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30.h,
            color: Colors.white,
          ),
          onPressed: () async {
            navigatorHelper.pop();
          },
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(30),
          minScale: 0.5,
          maxScale: 4.0,
          panEnabled: false,
          child: Image.network(articleEntity.image!, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
