import 'dart:convert';

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
import '../../bloc/asam_urat/asam_urat_cubit.dart';
import '../../bloc/asam_urat/asam_urat_state.dart';
import '../../widget/custom_date_scroll.dart';
import '../../widget/custom_empty_data.dart';

class AsamUratPage extends StatefulWidget {
  const AsamUratPage({super.key});

  @override
  State<AsamUratPage> createState() => _AsamUratPageState();
}

class _AsamUratPageState extends State<AsamUratPage> {
  final AsamUratCubit _asamUratCubit = sl<AsamUratCubit>();

  @override
  Widget build(BuildContext context) {
    return BasePage(
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
      body: ListView(
        children: [
          CustomDateScroll(
            onChanged: (DateTime value) async {
              await _asamUratCubit.getListAsamUrat(
                DateFormat('yyyy-MM-dd').format(value),
              );
            },
          ),
          const SizedBox(height: 8),
          BlocBuilder<AsamUratCubit, AsamUratState>(
            builder: (context, state) {
              if (state.asamUratState.status.isHasData &&
                  state.asamUratState.data!.isEmpty) {
                return const CustomEmptyData(
                  text: 'Asam Urat',
                  routePage: addAsamUratPage,
                );
              }
              if (state.asamUratState.status.isHasData &&
                  state.asamUratState.data!.isNotEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...state.asamUratState.data!.asMap().entries.map((e) {
                      // var status = '(K) Kurang';
                      // if (userData['gender'].toString().contains('laki')) {
                      //   if (e.value.total >= 3.5 && e.value.total <= 7) {
                      //     status = '(N) Normal';
                      //   } else if (e.value.total > 7) {
                      //     status = '(T) Tinggi';
                      //   }
                      // } else if (userData['gender'].toString().contains(
                      //   'wanita',
                      // )) {
                      //   if (e.value.total >= 2.6 && e.value.total <= 6) {
                      //     status = '(N) Normal';
                      //   } else if (e.value.total > 6) {
                      //     status = '(T) Tinggi';
                      //   }
                      // }
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
                                // Text(status),
                                Text('${e.value.total} mg/dL'),
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
                        Navigator.pushNamed(context, addAsamUratPage);
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
