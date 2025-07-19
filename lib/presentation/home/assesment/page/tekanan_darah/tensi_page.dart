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
import '../../bloc/tekanan_darah/tensi_cubit.dart';
import '../../bloc/tekanan_darah/tensi_state.dart';
import '../../widget/custom_date_scroll.dart';
import '../../widget/custom_empty_data.dart';

class TensiPage extends StatefulWidget {
  const TensiPage({super.key});

  @override
  State<TensiPage> createState() => _TensiPageState();
}

class _TensiPageState extends State<TensiPage> {
  final TensiCubit _tensiCubit = sl<TensiCubit>();

  @override
  Widget build(BuildContext context) {
    return BasePage(
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
      body: ListView(
        children: [
          CustomDateScroll(
            onChanged: (DateTime value) async {
              await _tensiCubit.getListTensi(
                DateFormat('yyyy-MM-dd').format(value),
              );
            },
          ),
          SizedBox(height: 8.h),
          BlocBuilder<TensiCubit, TensiState>(
            builder: (context, state) {
              if (state.tensiState.status.isHasData &&
                  state.tensiState.data!.isEmpty) {
                return const CustomEmptyData(
                  text: 'Tekanan Darah',
                  routePage: addTensiPage,
                );
              }
              if (state.tensiState.status.isHasData &&
                  state.tensiState.data!.isNotEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...state.tensiState.data!.asMap().entries.map((e) {
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.value.time),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${e.value.sistole}/${e.value.diastole} mmHg',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 18.h),
                    CustomButton(
                      textButton: 'Tambahkan',
                      onTap: () {
                        Navigator.pushNamed(context, addTensiPage);
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
