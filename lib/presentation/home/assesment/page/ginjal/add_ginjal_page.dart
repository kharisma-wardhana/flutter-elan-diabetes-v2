import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/app_navigator.dart';
import '../../../../../core/service_locator.dart';
import '../../../../widget/base_page.dart';
import '../../../../widget/custom_button.dart';
import '../../../../widget/custom_dropdown.dart';
import '../../../../widget/custom_text_field.dart';
import '../../bloc/ginjal/ginjal_cubit.dart';
import '../../widget/custom_date_picker.dart';

class AddGinjalPage extends StatefulWidget {
  const AddGinjalPage({super.key});

  @override
  State<AddGinjalPage> createState() => _AddGinjalPageState();
}

class _AddGinjalPageState extends State<AddGinjalPage> {
  static final AppNavigator _navigationHelper = sl<AppNavigator>();
  static final GinjalCubit _ginjalCubit = sl<GinjalCubit>();

  bool isLoading = false;
  final TextEditingController dateController = TextEditingController(text: '');
  final TextEditingController typeController = TextEditingController(
    text: 'Ureum',
  );
  final TextEditingController totalController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  static final List<String> typeList = ['Ureum', 'Kreatinin'];
  late int typeInt;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      isLoading: isLoading,
      appBar: AppBar(
        title: Text('Ureum & Kreatinin'),
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
            CustomDropdown(
              controller: typeController,
              items: typeList,
              onChanged: (val) {
                typeController.text = val;
              },
            ),
            CustomTextField(
              controller: totalController,
              keyboardType: TextInputType.number,
              labelText: 'Jumlah',
              suffixIcon: const Text('mg/dL'),
            ),
            CustomButton(
              textButton: 'Tambahkan',
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                    if (typeController.text.toLowerCase().contains('ureum')) {
                      typeInt = 0;
                    } else {
                      typeInt = 1;
                    }
                  });
                  await _ginjalCubit.addGinjal(
                    dateController.text,
                    typeInt,
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
