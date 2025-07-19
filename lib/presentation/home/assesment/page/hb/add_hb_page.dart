import 'package:elan/core/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/service_locator.dart';
import '../../../../widget/base_page.dart';
import '../../../../widget/custom_button.dart';
import '../../../../widget/custom_text_field.dart';
import '../../bloc/hb1ac/hb1ac_cubit.dart';
import '../../widget/custom_date_picker.dart';

class AddHbPage extends StatefulWidget {
  const AddHbPage({super.key});

  @override
  State<AddHbPage> createState() => _AddHbPageState();
}

class _AddHbPageState extends State<AddHbPage> {
  static final AppNavigator _navigationHelper = sl<AppNavigator>();
  static final Hb1acCubit _hb1acCubit = sl<Hb1acCubit>();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  final TextEditingController dateController = TextEditingController(text: '');
  final TextEditingController totalController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BasePage(
      isLoading: isLoading,
      appBar: AppBar(
        title: Text('HbA1c'),
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomDatePicker(controller: dateController),
            CustomTextField(
              controller: totalController,
              keyboardType: TextInputType.number,
              labelText: 'Jumlah',
              suffixIcon: const Text('%'),
            ),
            CustomButton(
              textButton: 'Tambahkan',
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => isLoading = true);
                  await _hb1acCubit.addHba1c(
                    dateController.text,
                    double.parse(totalController.text),
                  );
                  _navigationHelper.pop();
                  setState(() => isLoading = false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
