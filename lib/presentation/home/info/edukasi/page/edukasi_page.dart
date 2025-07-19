import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/app_navigator.dart';
import '../../../../../core/constant.dart';
import '../../../../../core/service_locator.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../widget/base_page.dart';

class EdukasiPage extends StatefulWidget {
  const EdukasiPage({super.key});

  @override
  State<EdukasiPage> createState() => _EdukasiPageState();
}

class _EdukasiPageState extends State<EdukasiPage> {
  final navigatorHelper = sl<AppNavigator>();
  final List<Map<String, dynamic>> edukasi = [
    {
      'title': 'Apa yang Dilakukan Agar Selamat dan Aman Saat Banjir',
      'image': [
        Assets.images.apaYangDilakukanAgarSelamatDanAmanSaatBanjir.path,
      ],
    },
    {
      'title': 'Apa yang Dilakukan Agar Selamat dan Aman Saat Kebakaran',
      'image': [
        Assets.images.apaYangDilakukanAgarSelamatDanAmanSaatKebakaran.path,
      ],
    },
    {
      'title': 'Apa Saja yang Harus Dibawa Dalam Tas Siaga Bencana',
      'image': [Assets.images.apaSajaYangHarusDibawaDalamTasSiagaBencana.path],
    },
    {
      'title': 'Edukasi Bencana Untuk Lansia',
      'image': [
        Assets.images.edukasiBencanaUntukLansia1.path,
        Assets.images.edukasiBencanaUntukLansia2.path,
        Assets.images.edukasiBencanaUntukLansia3.path,
        Assets.images.edukasiBencanaUntukLansia4.path,
        Assets.images.edukasiBencanaUntukLansia5.path,
        Assets.images.edukasiBencanaUntukLansia6.path,
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(
        title: Text('Edukasi Bencana'),
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
        children: edukasi
            .map(
              (e) => ListTile(
                title: Text(e['title']),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  navigatorHelper.pushNamed(edukasiDetailPage, arguments: e);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
