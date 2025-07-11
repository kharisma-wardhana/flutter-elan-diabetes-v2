import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/service_locator.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  TextEditingController activityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize any necessary state here
  }

  @override
  void dispose() {
    activityController.dispose();
    super.dispose();
  }

  void _handleActivityInput() {
    if (_formKey.currentState!.validate()) {
      // Logic to handle activity input
      context.read<AuthBloc>().add(CompleteOnboardingEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ELAN')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  labelText: 'Aktivitas Harian',
                  hintText: 'Masukkan Aktivitas Harian',
                  validatorEmpty: 'Aktivitas Harian tidak boleh kosong',
                  keyboardType: TextInputType.text,
                  controller: activityController,
                  onChanged: (val) {
                    // Logic to handle activity input
                    activityController.text = val;
                  },
                ),
                32.verticalSpace,
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      sl<AppNavigator>().pushNamedAndRemoveUntil(homePage);
                    } else if (state is AuthError) {
                      Fluttertoast.showToast(
                        msg: state.message,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  child: CustomButton(
                    textButton: "Lanjutkan",
                    onTap: _handleActivityInput,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
