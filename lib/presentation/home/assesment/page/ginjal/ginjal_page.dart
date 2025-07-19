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
import '../../bloc/ginjal/ginjal_cubit.dart';
import '../../bloc/ginjal/ginjal_state.dart';
import '../../widget/custom_date_scroll.dart';
import '../../widget/custom_empty_data.dart';

class GinjalPage extends StatefulWidget {
  const GinjalPage({super.key});

  @override
  State<GinjalPage> createState() => _GinjalPageState();
}

class _GinjalPageState extends State<GinjalPage> {
  final GinjalCubit _ginjalCubit = sl<GinjalCubit>();

  @override
  Widget build(BuildContext context) {
    return BasePage(
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
      body: ListView(
        children: [
          CustomDateScroll(
            onChanged: (DateTime value) async {
              await _ginjalCubit.getListGinjal(
                DateFormat('yyyy-MM-dd').format(value),
              );
            },
          ),
          const SizedBox(height: 8),
          BlocBuilder<GinjalCubit, GinjalState>(
            builder: (context, state) {
              if (state.ginjalState.status.isHasData &&
                  state.ginjalState.data!.isEmpty) {
                return const CustomEmptyData(
                  text: 'Ureum & Kreatinin',
                  routePage: addGinjalPage,
                );
              }
              if (state.ginjalState.status.isHasData &&
                  state.ginjalState.data!.isNotEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...state.ginjalState.data!.asMap().entries.map((e) {
                      // var status = 'Rendah';
                      // if (userData['gender'].toString().contains('laki')) {
                      //   if (e.value.type == 0) {
                      //     if (e.value.total >= 8 && e.value.total <= 24) {
                      //       status = 'Normal';
                      //     } else if (e.value.total > 24) {
                      //       status = 'Tinggi';
                      //     }
                      //   } else {
                      //     if (e.value.total >= 0.6 && e.value.total <= 1.2) {
                      //       status = 'Normal';
                      //     } else if (e.value.total > 1.2) {
                      //       status = 'Tinggi';
                      //     }
                      //   }
                      // } else if (userData['gender'].toString().contains(
                      //   'wanita',
                      // )) {
                      //   if (e.value.type == 0) {
                      //     if (e.value.total >= 6 && e.value.total <= 21) {
                      //       status = 'Normal';
                      //     } else if (e.value.total > 21) {
                      //       status = 'Tinggi';
                      //     }
                      //   } else {
                      //     if (e.value.total >= 0.5 && e.value.total <= 1.1) {
                      //       status = 'Normal';
                      //     } else if (e.value.total > 1.1) {
                      //       status = 'Tinggi';
                      //     }
                      //   }
                      // }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          color: ColorName.lightGrey,
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.value.type == 0 ? 'Ureum' : 'Kreatinin'),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${e.value.total} mg/dL'),
                                    // Text(status),
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
                        Navigator.pushNamed(context, addGinjalPage);
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
