import 'package:elan/core/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/app_navigator.dart';
import '../../../../../core/constant.dart';
import '../../../../../core/service_locator.dart';
import '../../../../../domain/entities/antropometri_entity.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../auth/bloc/auth_bloc.dart';
import '../../../../auth/bloc/auth_event.dart';
import '../../../../widget/base_page.dart';
import '../../../../widget/custom_button.dart';
import '../../../../widget/custom_dropdown.dart';
import '../../../../widget/custom_text_field.dart';
import '../../bloc/antropometri/antropometri_cubit.dart';
import '../../bloc/antropometri/antropometri_state.dart';

class AntropometriPage extends StatefulWidget {
  const AntropometriPage({super.key});

  @override
  State<AntropometriPage> createState() => _AntropometriPageState();
}

class _AntropometriPageState extends State<AntropometriPage> {
  static final AppNavigator navigationHelper = sl<AppNavigator>();
  static final AntropometriCubit antropometriCubit = sl<AntropometriCubit>();
  final TextEditingController heightController = TextEditingController(
    text: '',
  );
  final TextEditingController weightController = TextEditingController(
    text: '',
  );
  final TextEditingController stomachController = TextEditingController(
    text: '',
  );
  final TextEditingController handController = TextEditingController(text: '');
  final TextEditingController statusController = TextEditingController(
    text: '',
  );
  final TextEditingController resultController = TextEditingController(
    text: '',
  );
  final TextEditingController infoPerutController = TextEditingController(
    text: '',
  );
  final TextEditingController infoLenganController = TextEditingController(
    text: '',
  );
  final TextEditingController jenisAktivitasController = TextEditingController(
    text: 'Sangat jarang berolahraga (1-3 kali per bulan)',
  );
  static final _formKey = GlobalKey<FormState>();
  static final List<String> jenisAktivitas = [
    'Sangat jarang berolahraga (1-3 kali per bulan)',
    'Jarang olahraga (1-3 kali per minggu)',
    'Cukup olahraga (3-5 kali per minggu)',
    'Sering olahraga (6-7 kali per minggu)',
    'Sangat sering olahraga (sekitar 2 kali dalam sehari)',
  ];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final status = context
        .read<AntropometriCubit>()
        .state
        .antropometriState
        .status;
    if (status.isHasData) {
      final AntropometriEntity antropometriEntity = context
          .read<AntropometriCubit>()
          .state
          .antropometriState
          .data!;
      heightController.text = antropometriEntity.height.toString();
      weightController.text = antropometriEntity.weight.toString();
      handController.text = antropometriEntity.hand.toString();
      stomachController.text = antropometriEntity.stomach.toString();
      var result =
          (antropometriEntity.weight / (antropometriEntity.height * 0.02));
      resultController.text = result.toStringAsFixed(2);
      if (result < 18.5) {
        statusController.text = '${resultController.text} (Kurus)';
      } else if (result >= 18.5 && result <= 24.9) {
        statusController.text = '${resultController.text} (Normal)';
      } else {
        statusController.text = '${resultController.text} (Obesitas)';
      }
      jenisAktivitasController.text =
          antropometriEntity.activity ?? 'Sangat jarang berolahraga';
      isLoading = false;
    }
  }

  void _updateData() {
    setState(() {
      if (heightController.text.isNotEmpty ||
          weightController.text.isNotEmpty) {
        var height = heightController.text.isEmpty
            ? 0
            : double.parse(heightController.text);
        var weight = weightController.text.isEmpty
            ? 0
            : double.parse(weightController.text);
        var result = (weight / (height * 0.02));
        resultController.text = result.toStringAsFixed(2);
        if (result < 18.5) {
          statusController.text = '${resultController.text} (Kurus)';
        } else if (result >= 18.5 && result <= 24.9) {
          statusController.text = '${resultController.text} (Normal)';
        } else {
          statusController.text = '${resultController.text} (Obesitas)';
        }
      }
    });
  }

  void _updateLengan() {
    if (handController.text.isNotEmpty) {
      setState(() {
        double val = double.parse(handController.text);
        if (val >= 21) {
          infoLenganController.text = 'Normal';
        } else {
          infoLenganController.text = 'Malnutrisi';
        }
      });
    }
  }

  void _updatePerut() {
    // if (stomachController.text.isNotEmpty) {
    //   setState(() {
    //     double val = double.parse(stomachController.text);
    //     if (userData['gender'].toString().toLowerCase().contains('laki-laki')) {
    //       infoPerutController.text = 'Normal';
    //       if (val > 90) {
    //         infoPerutController.text = 'Obesitas Sentral';
    //       }
    //     } else if (userData['gender'].toString().toLowerCase().contains(
    //       'wanita',
    //     )) {
    //       infoPerutController.text = 'Normal';
    //       if (val > 80) {
    //         infoPerutController.text = 'Obesitas Sentral';
    //       }
    //     }
    //   });
    // }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      context.read<AntropometriCubit>().addAntropometri(
        double.parse(heightController.text),
        double.parse(weightController.text),
        double.parse(stomachController.text),
        double.parse(handController.text),
        double.parse(resultController.text),
        statusController.text,
        jenisAktivitasController.text,
      );
      context.read<AuthBloc>().add(CompleteAntropometriEvent());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      isLoading: isLoading,
      appBar: AppBar(title: Text('Profil Kesehatan')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              8.verticalSpace,
              CustomTextField(
                controller: heightController,
                labelText: 'Tinggi Badan',
                suffixIcon: const Text('cm'),
                keyboardType: TextInputType.number,
                validatorEmpty: 'Silahkan masukkan tinggi badan',
                onChanged: (_) {
                  _updateData();
                },
              ),
              8.verticalSpace,
              CustomTextField(
                controller: weightController,
                labelText: 'Berat Badan',
                suffixIcon: const Text('kg'),
                keyboardType: TextInputType.number,
                validatorEmpty: 'Silahkan masukkan berat badan',
                onChanged: (_) {
                  _updateData();
                },
              ),
              8.verticalSpace,
              CustomTextField(
                controller: statusController,
                labelText: 'Status IMT',
                keyboardType: TextInputType.number,
                isReadOnly: true,
              ),
              8.verticalSpace,
              CustomTextField(
                controller: stomachController,
                labelText: 'Lingkar Perut',
                suffixIcon: const Text('cm'),
                infoText: infoPerutController.text,
                infoTextColor:
                    infoPerutController.text.toLowerCase().contains('normal')
                    ? ColorName.darkGrey
                    : Colors.red,
                validatorEmpty: 'Silahkan masukkan lingkar perut',
                keyboardType: TextInputType.number,
                onChanged: (_) {
                  _updatePerut();
                },
              ),
              8.verticalSpace,
              CustomTextField(
                controller: handController,
                labelText: 'Lingkar Lengan',
                infoText: infoLenganController.text,
                infoTextColor:
                    infoLenganController.text.toLowerCase().contains('normal')
                    ? ColorName.darkGrey
                    : Colors.red,
                suffixIcon: const Text('cm'),
                validatorEmpty: 'Silahkan masukkan lingkar lengan',
                keyboardType: TextInputType.number,
                onChanged: (_) {
                  _updateLengan();
                },
              ),
              8.verticalSpace,
              const Text('Jenis Aktivitas yang sering dilakukan?'),
              CustomDropdown(
                controller: jenisAktivitasController,
                items: jenisAktivitas,
                onChanged: (val) {
                  setState(() {
                    jenisAktivitasController.text = val;
                  });
                },
              ),
              16.verticalSpace,
              BlocListener<AntropometriCubit, AntropometriState>(
                listener: (context, state) {
                  if (state.antropometriState.status.isHasData) {
                    // navigationHelper.pushReplacementNamed(homePage);
                    navigationHelper.pushReplacementNamed(splashPage);
                  } else if (state.antropometriState.status.isError) {
                    Fluttertoast.showToast(
                      msg: state.antropometriState.message,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 18.sp,
                    );
                  }
                },
                child: CustomButton(textButton: 'Submit', onTap: _handleSubmit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
