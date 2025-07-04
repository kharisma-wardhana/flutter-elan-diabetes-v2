import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/service_locator.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  TextEditingController activityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize any necessary state here
  }

  @override
  void dispose() {
    activityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ELAN')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                labelText: 'Aktivitas Harian',
                hintText: 'Masukkan Aktivitas Harian',
                validatorEmpty: 'Aktivitas Harian tidak boleh kosong',
                keyboardType: TextInputType.text,
                controller: activityController,
                onChanged: (val) {
                  // Logic to handle activity input
                  activityController.text = val;
                },
              ),
              32.verticalSpace,
              CustomButton(
                textButton: "Lanjutkan",
                onTap: () {
                  // Logic to navigate to the next page
                  sl<AppNavigator>().pushNamed(homePage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
