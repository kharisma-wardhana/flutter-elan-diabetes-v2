import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/app_navigator.dart';
import '../../../../../core/service_locator.dart';
import '../../../../widget/base_page.dart';
import '../../../../widget/custom_button.dart';
import '../../../../widget/custom_text_field.dart';
import '../../bloc/asam_urat/asam_urat_cubit.dart';
import '../../widget/custom_date_picker.dart';

class AddAsamUratPage extends StatefulWidget {
  const AddAsamUratPage({super.key});

  @override
  State<AddAsamUratPage> createState() => _AddAsamUratPageState();
}

class _AddAsamUratPageState extends State<AddAsamUratPage> {
  static final AppNavigator _navigationHelper = sl<AppNavigator>();
  static final AsamUratCubit _asamUratCubit = sl<AsamUratCubit>();

  bool isLoading = false;
  final TextEditingController dateController = TextEditingController(text: '');
  final TextEditingController totalController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      isLoading: isLoading,
      appBar: AppBar(
        title: Text('Asam Urat'),
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
              labelText: 'Jumlah',
              suffixIcon: const Text('mg/dL'),
              keyboardType: TextInputType.number,
            ),
            CustomButton(
              textButton: 'Tambahkan',
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => isLoading = true);
                  await _asamUratCubit.addAsamUrat(
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
