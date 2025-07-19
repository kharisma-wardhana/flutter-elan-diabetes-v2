import 'package:elan/core/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/service_locator.dart';
import '../../../../widget/base_page.dart';
import '../../../../widget/custom_button.dart';
import '../../../../widget/custom_text_field.dart';
import '../../bloc/gula_darah/gula_cubit.dart';
import '../../widget/custom_date_picker.dart';
import '../../widget/custom_time_picker.dart';

class AddGulaPage extends StatefulWidget {
  const AddGulaPage({super.key});

  @override
  State<AddGulaPage> createState() => _AddGulaPageState();
}

class _AddGulaPageState extends State<AddGulaPage> {
  static final AppNavigator _navigationHelper = sl<AppNavigator>();
  static final GulaCubit _gulaCubit = sl<GulaCubit>();

  bool isLoading = false;
  final TextEditingController dateController = TextEditingController(text: '');
  final TextEditingController timeController = TextEditingController(text: '');
  final TextEditingController typeController = TextEditingController(
    text: 'Sebelum Makan',
  );
  final TextEditingController totalController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  static final List<String> typeList = [
    'Sebelum Makan',
    'Sesudah Makan',
    'Puasa',
  ];

  @override
  Widget build(BuildContext context) {
    return BasePage(
      isLoading: isLoading,
      appBar: AppBar(
        title: Text('Gula Darah'),
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
            CustomTimePicker(controller: timeController),
            DropdownButtonFormField(
              value: typeController.text,
              items: typeList.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: (value) {
                setState(() => typeController.text = value.toString());
              },
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: totalController,
              keyboardType: TextInputType.number,
              labelText: 'Kadar Glukosa',
              suffixIcon: const Text('mg/dL'),
            ),
            CustomButton(
              textButton: 'Tambahkan',
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => isLoading = true);
                  int typeInt = 0;
                  if (typeController.text == 'Sesudah Makan') {
                    typeInt = 1;
                  }
                  if (typeController.text == 'Puasa') {
                    typeInt = 2;
                  }
                  await _gulaCubit.addGula(
                    dateController.text,
                    timeController.text,
                    typeInt.toString(),
                    totalController.text,
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
