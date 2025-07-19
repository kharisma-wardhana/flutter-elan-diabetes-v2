import 'package:elan/core/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constant.dart';
import '../../../../../core/service_locator.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../widget/base_page.dart';
import '../../../../widget/custom_button.dart';
import '../../bloc/hb1ac/hb1ac_cubit.dart';
import '../../bloc/hb1ac/hb1ac_state.dart';
import '../../widget/custom_date_scroll.dart';
import '../../widget/custom_empty_data.dart';

class HbPage extends StatefulWidget {
  const HbPage({super.key});

  @override
  State<HbPage> createState() => _HbPageState();
}

class _HbPageState extends State<HbPage> {
  final Hb1acCubit _hb1acCubit = sl<Hb1acCubit>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BasePage(
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
      isLoading: isLoading,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomDateScroll(
              onChanged: (DateTime value) async {
                await _hb1acCubit.getListHb(
                  DateFormat('yyyy-MM-dd').format(value),
                );
              },
            ),
            16.verticalSpace,
            BlocConsumer<Hb1acCubit, Hb1acState>(
              listener: (context, state) {
                if (state.hbState.status.isLoading) {
                  setState(() => isLoading = true);
                }
              },
              builder: (context, state) {
                if (state.hbState.status.isHasData &&
                    state.hbState.data!.isEmpty) {
                  return const CustomEmptyData(
                    text: 'HbA1c',
                    routePage: addHbPage,
                  );
                }
                if (state.hbState.status.isHasData &&
                    state.hbState.data!.isNotEmpty) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...state.hbState.data!.asMap().entries.map((e) {
                        var status = 'Terbaik';
                        if (e.value.total > 4.5 && e.value.total <= 5.7) {
                          status = 'Normal';
                        } else if (e.value.total > 5.7 &&
                            e.value.total <= 6.4) {
                          status = 'Prediabetes';
                        } else if (e.value.total == 6.5) {
                          status = 'Diabetes Terkendali Baik';
                        } else if (e.value.total > 6.5 && e.value.total < 8) {
                          status = 'Diabetes Terkendali Sedang';
                        } else if (e.value.total >= 8) {
                          status = 'Diabetes Terkendali Buruk';
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            color: e.key % 2 == 0
                                ? ColorName.lightGrey
                                : Colors.green[100],
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text(status)),
                                  Text('${e.value.total} %'),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 18),
                      CustomButton(
                        textButton: 'Tambahkan',
                        onTap: () {
                          Navigator.pushNamed(context, addHbPage);
                        },
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
