import 'package:elan/core/state_enum.dart';
import 'package:elan/presentation/auth/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_navigator.dart';
import '../../../../../core/constant.dart';
import '../../../../../core/service_locator.dart';
import '../../../../../domain/entities/antropometri_entity.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../auth/bloc/auth_bloc.dart';
import '../../../../widget/base_page.dart';
import '../../../../widget/custom_button.dart';
import '../../../../widget/custom_dropdown.dart';
import '../../../../widget/custom_text_field.dart';
import '../../bloc/antropometri/antropometri_cubit.dart';

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
    if (antropometriCubit.state.antropometriState.status.isHasData &&
        antropometriCubit.state.antropometriState.data != null) {
      final AntropometriEntity antropometriEntity =
          antropometriCubit.state.antropometriState.data!;
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
      _addAntropometri();
      context.read<AuthBloc>().add(CompleteAntropometriEvent());
      setState(() {
        isLoading = false;
      });
      navigationHelper.pushReplacementNamed(homePage);
    }
  }

  void _addAntropometri() async {
    await antropometriCubit.addAntropometri(
      double.parse(heightController.text),
      double.parse(weightController.text),
      double.parse(stomachController.text),
      double.parse(handController.text),
      double.parse(resultController.text),
      statusController.text,
      jenisAktivitasController.text,
    );
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
              const SizedBox(height: 8),
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
              const SizedBox(height: 8),
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
              const SizedBox(height: 8),
              CustomTextField(
                controller: statusController,
                labelText: 'Status IMT',
                keyboardType: TextInputType.number,
                isReadOnly: true,
              ),
              const SizedBox(height: 8),
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
              const SizedBox(height: 8),
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
              const SizedBox(height: 8),
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
              const SizedBox(height: 16),
              CustomButton(textButton: 'Submit', onTap: _handleSubmit),
            ],
          ),
        ),
      ),
    );
  }
}
