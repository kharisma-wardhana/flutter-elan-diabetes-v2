import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/service_locator.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_loading.dart';
import '../../widget/custom_text_field.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';

class GulaDarahPage extends StatefulWidget {
  const GulaDarahPage({super.key});

  @override
  State<GulaDarahPage> createState() => _GulaDarahPageState();
}

class _GulaDarahPageState extends State<GulaDarahPage> {
  static final _formKey = GlobalKey<FormState>();
  bool isDiabetes = false;
  bool isLoading = false;
  TextEditingController gulaDarahPuasaController = TextEditingController();
  TextEditingController gulaDarahSewaktuController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isDiabetes = false; // Initialize to false, change based on logic
    isLoading = false; // Initialize loading state
  }

  @override
  void dispose() {
    isDiabetes = false; // Reset the state when disposing
    isLoading = false; // Reset loading state
    gulaDarahPuasaController.dispose();
    gulaDarahSewaktuController.dispose();
    super.dispose();
  }

  void _handleNextButton() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    context.read<OnboardingBloc>().add(
      OnboardingEvent.addGulaDarah(
        gulaDarahPuasa: gulaDarahPuasaController.text,
        gulaDarahSewaktu: gulaDarahSewaktuController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Gula Darah')),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      labelText: 'Gula Darah Puasa',
                      hintText: 'Masukkan Gula Darah Puasa',
                      keyboardType: TextInputType.number,
                      controller: gulaDarahPuasaController,
                      satuanText: 'mg/dL',
                      validatorEmpty: 'Gula Darah Puasa tidak boleh kosong',
                      disableValidation: true,
                    ),
                    16.verticalSpace,
                    CustomTextField(
                      labelText: 'Gula Darah Sewaktu',
                      hintText: 'Masukkan Gula Darah Sewaktu',
                      keyboardType: TextInputType.number,
                      controller: gulaDarahSewaktuController,
                      satuanText: 'mg/dL',
                      validatorEmpty: 'Gula Darah Sewaktu tidak boleh kosong',
                      disableValidation: true,
                    ),
                    16.verticalSpace,
                    BlocBuilder<OnboardingBloc, OnboardingState>(
                      builder: (context, state) {
                        if (state is OnboardingError) {
                          return Text(
                            state.message,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.sp,
                            ),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                    16.verticalSpace,
                    BlocListener<OnboardingBloc, OnboardingState>(
                      listener: (context, state) {
                        if (state is OnboardingLoading) {
                          setState(() => isLoading = true);
                        } else if (state is OnboardingSuccessNormal) {
                          setState(() => isLoading = false);
                          sl<AppNavigator>().pushNamedAndRemoveUntil(
                            recommendationPage,
                            arguments: recommendations['normal']!,
                          );
                        } else if (state is OnboardingSuccessDiabetes) {
                          setState(() => isLoading = false);
                          sl<AppNavigator>().pushNamedAndRemoveUntil(
                            recommendationPage,
                            arguments: recommendations['diabetes']!,
                          );
                        } else {
                          setState(() => isLoading = false);
                        }
                      },
                      child: CustomButton(
                        textButton: "Lanjutkan",
                        onTap: _handleNextButton,
                      ),
                    ),
                    32.verticalSpace,
                  ],
                ),
              ),
            ),
            if (isLoading) Positioned.fill(child: const CustomLoading()),
          ],
        ),
      ),
    );
  }
}
