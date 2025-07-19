import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/app_navigator.dart';
import '../../../../../core/service_locator.dart';
import '../../../../widget/base_page.dart';
import '../../../../widget/custom_button.dart';
import '../../../../widget/custom_text_field.dart';
import '../../bloc/tekanan_darah/tensi_cubit.dart';
import '../../widget/custom_date_picker.dart';
import '../../widget/custom_time_picker.dart';

class AddTensiPage extends StatefulWidget {
  const AddTensiPage({super.key});

  @override
  State<AddTensiPage> createState() => _AddTensiPageState();
}

class _AddTensiPageState extends State<AddTensiPage> {
  static final AppNavigator _navigationHelper = sl<AppNavigator>();
  static final TensiCubit _tensiCubit = sl<TensiCubit>();

  bool isLoading = false;
  final TextEditingController dateController = TextEditingController(text: '');
  final TextEditingController sistoleController = TextEditingController(
    text: '',
  );
  final TextEditingController diastoleController = TextEditingController(
    text: '',
  );
  final TextEditingController timeController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      isLoading: isLoading,
      appBar: AppBar(
        title: Text('Tekanan Darah'),
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
            CustomTextField(
              controller: sistoleController,
              labelText: 'Sistole',
              suffixIcon: const Text('mmHg'),
              keyboardType: TextInputType.number,
            ),
            CustomTextField(
              controller: diastoleController,
              labelText: 'Diastole',
              suffixIcon: const Text('mmHg'),
              keyboardType: TextInputType.number,
            ),
            CustomButton(
              textButton: 'Tambahkan',
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => isLoading = true);
                  await _tensiCubit.addTensi(
                    dateController.text,
                    timeController.text,
                    int.parse(sistoleController.text),
                    int.parse(diastoleController.text),
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
