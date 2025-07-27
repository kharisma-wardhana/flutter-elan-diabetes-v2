import 'dart:convert';

import 'package:elan/core/constant.dart';
import 'package:elan/core/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import '../../../../../core/app_navigator.dart';
import '../../../../../core/service_locator.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../widget/base_page.dart';
import '../../../../widget/custom_button.dart';
import '../../bloc/water/water_cubit.dart';
import '../../bloc/water/water_state.dart';
import '../../widget/custom_date_scroll.dart';

class KonsumsiAirPage extends StatefulWidget {
  const KonsumsiAirPage({super.key});

  @override
  State<KonsumsiAirPage> createState() => _KonsumsiAirPageState();
}

class _KonsumsiAirPageState extends State<KonsumsiAirPage> {
  static final AppNavigator _navigationHelper = sl<AppNavigator>();
  static final WaterCubit _waterCubit = sl<WaterCubit>();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  int currentTarget = 0;
  int totalMinum = 1;
  final TextEditingController dateController = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
  );
  final TextEditingController targetController = TextEditingController(
    text: '',
  );
  final TextEditingController totalController = TextEditingController(text: '');

  @override
  void initState() async {
    super.initState();
    currentTarget = await getRecommend();
  }

  Future<int> getRecommend() async {
    int weight = await sl<FlutterSecureStorage>()
        .read(key: antropometriKey)
        .then((value) => jsonDecode(value ?? '{}')['weight'] ?? 0);
    double recommend = (1500 + (20 * (weight - 20))) / 220;
    return recommend.ceil();
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey[50],
              ),
              height: 350,
              child: Column(
                children: [
                  const Text('Target Harian'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          setModalState(() async {
                            final recommendation = await getRecommend();
                            if (currentTarget > recommendation) {
                              currentTarget = currentTarget - 1;
                            }
                          });
                        },
                      ),
                      Text('$currentTarget Gelas'),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          setModalState(() {
                            currentTarget = currentTarget + 1;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '1 gelas = 200-220 ml',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  CustomButton(
                    textButton: 'Simpan Target',
                    onTap: () async {
                      setState(() => isLoading = true);
                      await _waterCubit.addWater(
                        dateController.text,
                        currentTarget,
                        0,
                      );
                      _navigationHelper.pop();
                      setState(() => isLoading = false);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
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
      isLoading: isLoading,
      body: ListView(
        children: [
          CustomDateScroll(
            onChanged: (DateTime value) async {
              await _waterCubit.getAllWater(
                DateFormat('yyyy-MM-dd').format(value),
              );
              dateController.text = DateFormat('yyyy-MM-dd').format(value);
            },
          ),
          const SizedBox(height: 8),
          BlocBuilder<WaterCubit, WaterState>(
            builder: (context, state) {
              if (state.waterState.status.isHasData) {
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      CustomButton(
                        textButton: 'Ubah Target',
                        onTap: () {
                          _showModalBottomSheet(context);
                        },
                      ),
                      const SizedBox(height: 8),
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
                            setState(() => isLoading = false);
                          }
                        },
                      ),
                      const SizedBox(height: 18),
                      ...state.waterState.data!.map((e) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            color: ColorName.lightGrey,
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text('Rekomendasi'),
                                      Text('${getRecommend()}'),
                                      const Text('Gelas'),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Text('Target'),
                                      Text('${e.target}'),
                                      const Text('Gelas'),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Text('Total'),
                                      Text('${e.total}'),
                                      const Text('Gelas'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              }
              if (state.waterState.status.isError) {
                return const Center(
                  child: Text(
                    'Gagal memuat data',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(color: ColorName.primary),
              );
            },
          ),
        ],
      ),
    );
  }
}
