import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/app_navigator.dart';
import '../../../../../core/service_locator.dart';
import '../../../../widget/base_page.dart';
import '../../../../widget/custom_button.dart';
import '../../../../widget/custom_text_field.dart';
import '../../bloc/kolesterol/kolesterol_cubit.dart';
import '../../widget/custom_date_picker.dart';

class AddKolesterolPage extends StatefulWidget {
  const AddKolesterolPage({super.key});

  @override
  State<AddKolesterolPage> createState() => _AddKolesterolPageState();
}

class _AddKolesterolPageState extends State<AddKolesterolPage> {
  static final AppNavigator _navigationHelper = sl<AppNavigator>();
  static final KolesterolCubit _kolesterolCubit = sl<KolesterolCubit>();

  bool isLoading = false;
  final TextEditingController dateController = TextEditingController(text: '');
  final TextEditingController typeController = TextEditingController(
    text: 'LDL',
  );
  final TextEditingController totalController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  static final List<String> typeList = ['LDL', 'HDL', 'Trigliserida', 'Total'];

  @override
  Widget build(BuildContext context) {
    return BasePage(
      isLoading: isLoading,
      appBar: AppBar(
        title: Text('Kolesterol'),
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
              labelText: 'Kadar',
              suffixIcon: const Text('mg/dL'),
            ),
            CustomButton(
              textButton: 'Tambahkan',
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => isLoading = true);
                  await _kolesterolCubit.addKolesterol(
                    dateController.text,
                    typeController.text,
                    int.parse(totalController.text),
                  );
                  setState(() => isLoading = false);
                  _navigationHelper.pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
