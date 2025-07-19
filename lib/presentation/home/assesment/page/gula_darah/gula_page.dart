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
import '../../bloc/gula_darah/gula_cubit.dart';
import '../../bloc/gula_darah/gula_state.dart';
import '../../widget/custom_date_scroll.dart';
import '../../widget/custom_empty_data.dart';

class GulaPage extends StatefulWidget {
  const GulaPage({super.key});

  @override
  State<GulaPage> createState() => _GulaPageState();
}

class _GulaPageState extends State<GulaPage> {
  final GulaCubit _gulaCubit = sl<GulaCubit>();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(
        title: Text('Kadar Gula Darah'),
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
              await _gulaCubit.getListGula(
                DateFormat('yyyy-MM-dd').format(value),
              );
            },
          ),
          const SizedBox(height: 8),
          BlocBuilder<GulaCubit, GulaState>(
            builder: (context, state) {
              if (state.gulaState.status.isHasData &&
                  state.gulaState.data!.isEmpty) {
                return const CustomEmptyData(
                  text: 'Gula Darah',
                  routePage: addGulaPage,
                );
              }
              if (state.gulaState.status.isHasData &&
                  state.gulaState.data!.isNotEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Waktu Pemeriksaan',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Hasil Pemeriksaan',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    ...state.gulaState.data!.asMap().entries.map((e) {
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Pukul ${e.value.time}'),
                                    Text('${e.value.type}'),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text('${e.value.total} mg/dL')],
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
                        Navigator.pushNamed(context, addGulaPage);
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
