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
import '../../bloc/kolesterol/kolesterol_cubit.dart';
import '../../bloc/kolesterol/kolesterol_state.dart';
import '../../widget/custom_date_scroll.dart';
import '../../widget/custom_empty_data.dart';

class KolesterolPage extends StatefulWidget {
  const KolesterolPage({super.key});

  @override
  State<KolesterolPage> createState() => _KolesterolPageState();
}

class _KolesterolPageState extends State<KolesterolPage> {
  final KolesterolCubit _kolesterolCubit = sl<KolesterolCubit>();
  @override
  Widget build(BuildContext context) {
    return BasePage(
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
      body: ListView(
        children: [
          CustomDateScroll(
            onChanged: (DateTime value) async {
              await _kolesterolCubit.getListKolesterol(
                DateFormat('yyyy-MM-dd').format(value),
              );
            },
          ),
          const SizedBox(height: 8),
          BlocBuilder<KolesterolCubit, KolesterolState>(
            builder: (context, state) {
              if (state.kolesterolState.status.isHasData &&
                  state.kolesterolState.data!.isEmpty) {
                return const CustomEmptyData(
                  text: 'Kolesterol',
                  routePage: addKolesterolPage,
                );
              }
              if (state.kolesterolState.status.isHasData &&
                  state.kolesterolState.data!.isNotEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...state.kolesterolState.data!.asMap().entries.map((e) {
                      var status = 'Baik';
                      if (e.value.type.contains('Total')) {
                        if (e.value.total > 200 && e.value.total <= 239) {
                          status = 'Perbatasan';
                        } else if (e.value.total >= 240) {
                          status = 'Bahaya';
                        }
                      } else if (e.value.type.contains('LDL')) {
                        if (e.value.total > 130 && e.value.total <= 159) {
                          status = 'Perbatasan';
                        } else if (e.value.total >= 160) {
                          status = 'Bahaya';
                        }
                      } else if (e.value.type.contains('HDL')) {
                        if (e.value.total >= 40 && e.value.total <= 59) {
                          status = 'Perbatasan';
                        } else if (e.value.total < 40) {
                          status = 'Bahaya';
                        }
                      } else if (e.value.type.contains('Trigliserida')) {
                        if (e.value.total >= 200 && e.value.total < 400) {
                          status = 'Perbatasan';
                        } else if (e.value.total >= 400) {
                          status = 'Bahaya';
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          color: e.key % 2 == 0
                              ? ColorName.lightGrey
                              : Colors.green[100],
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(e.value.type),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('${e.value.total} mg/dL'),
                                    Text(status),
                                  ],
                                ),
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
                        Navigator.pushNamed(context, addKolesterolPage);
                      },
                    ),
                  ],
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
