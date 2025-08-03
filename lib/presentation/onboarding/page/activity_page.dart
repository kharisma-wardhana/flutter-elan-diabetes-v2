import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/service_locator.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_loading.dart';
import '../../widget/custom_text_field.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  TextEditingController activityController = TextEditingController();
  TextEditingController activityLainController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isActivityLainSelected = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize any necessary state here
    isActivityLainSelected = false; // Default to false
    isLoading = false; // Default loading state
  }

  @override
  void dispose() {
    activityController.dispose();
    activityLainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ELAN')),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aktivitas Harian',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    16.verticalSpace,
                    DropdownMenu(
                      width: double.infinity,
                      dropdownMenuEntries: activityOptions,
                      initialSelection: activityOptions.first,
                      onSelected: (value) {
                        // Handle dropdown selection
                        setState(() {
                          isActivityLainSelected = value == 'Lainnya';
                          if (!isActivityLainSelected) {
                            activityLainController.clear();
                          }
                        });
                      },
                      hintText: 'Pilih Aktivitas',
                      controller: activityController,
                    ),
                    16.verticalSpace,
                    isActivityLainSelected
                        ? CustomTextField(
                            labelText: 'Aktivitas Harian',
                            hintText: 'Masukkan Aktivitas Harian',
                            validatorEmpty:
                                'Aktivitas Harian tidak boleh kosong',
                            keyboardType: TextInputType.text,
                            controller: activityLainController,
                          )
                        : SizedBox.shrink(),
                    Spacer(),
                    CustomButton(
                      textButton: "Lanjutkan",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          sl<AppNavigator>().pushNamed(antropometriPage);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (isLoading) Positioned.fill(child: const CustomLoading()),
          ],
        ),
      ),
    );
  }
}
