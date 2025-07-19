import 'dart:convert';

import 'package:elan/core/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/service_locator.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../widget/base_page.dart';
import '../../../../widget/custom_button.dart';
import '../../bloc/water/water_cubit.dart';
import '../../widget/custom_date_picker.dart';

class AddKonsumsiAirPage extends StatefulWidget {
  const AddKonsumsiAirPage({super.key});

  @override
  State<AddKonsumsiAirPage> createState() => _AddKonsumsiAirPageState();
}

class _AddKonsumsiAirPageState extends State<AddKonsumsiAirPage> {
  static final AppNavigator _navigationHelper = sl<AppNavigator>();
  final WaterCubit _waterCubit = sl<WaterCubit>();
  final antropometri = jsonDecode(
    sl<SharedPreferences>().getString('antropometri')!,
  );

  final water = sl<SharedPreferences>().getString('water') != null
      ? jsonDecode(sl<SharedPreferences>().getString('water')!)
      : null;

  bool isLoading = false;
  final TextEditingController dateController = TextEditingController(text: '');
  final TextEditingController targetController = TextEditingController(
    text: '',
  );
  final TextEditingController totalController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  int currentTarget = 0;
  int totalMinum = 1;

  int getRecommend() {
    int weight = antropometri['berat'];
    double recommend = (1500 + (20 * (weight - 20))) / 220;
    return recommend.ceil();
  }

  @override
  void initState() {
    currentTarget = water != null ? water['target'] : getRecommend();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      isLoading: isLoading,
      appBar: AppBar(
        title: Text('Konsumsi Air'),
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
          children: <Widget>[
            const Text('Target Harian'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: currentTarget > getRecommend()
                        ? ColorName.primary
                        : ColorName.darkGrey,
                  ),
                  onPressed: () {
                    setState(() {
                      if (currentTarget > getRecommend()) {
                        currentTarget = currentTarget - 1;
                      }
                    });
                  },
                ),
                Text('$currentTarget Gelas'),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: ColorName.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      currentTarget = currentTarget + 1;
                    });
                  },
                ),
              ],
            ),
            CustomDatePicker(controller: dateController),
            const Text('Saya minum'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline,
                    size: 50,
                    color: totalMinum > 1
                        ? ColorName.primary
                        : ColorName.darkGrey,
                  ),
                  onPressed: () {
                    setState(() {
                      if (totalMinum > 1) {
                        totalMinum = totalMinum - 1;
                      }
                    });
                  },
                ),
                Text('$totalMinum Gelas'),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    size: 50,
                    color: ColorName.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      totalMinum = totalMinum + 1;
                    });
                  },
                ),
              ],
            ),
            CustomButton(
              textButton: 'Tambahkan',
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => isLoading = true);
                  await _waterCubit.addWater(
                    dateController.text,
                    currentTarget,
                    totalMinum,
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
