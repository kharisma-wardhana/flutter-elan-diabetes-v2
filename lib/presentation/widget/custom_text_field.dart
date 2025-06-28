import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../gen/colors.gen.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String? errorText;
  final TextInputType? keyboardType;
  final String? validatorEmpty;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmit;
  final String? initialValue;
  final String? satuanText;
  final String? infoText;
  final GestureTapCallback? onTap;
  final bool obscureText;
  final bool isReadOnly;
  final bool disableValidation;
  final Color infoTextColor;

  const CustomTextField({
    super.key,
    this.labelText = '',
    this.hintText = '',
    this.satuanText = '',
    this.errorText,
    this.keyboardType,
    this.validatorEmpty,
    this.controller,
    this.onChanged,
    this.suffixIcon,
    this.textInputAction = TextInputAction.next,
    this.onSubmit,
    this.initialValue,
    this.infoText,
    this.onTap,
    this.obscureText = false,
    this.isReadOnly = false,
    this.disableValidation = false,
    this.infoTextColor = ColorName.darkGrey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: controller,
                onChanged: onChanged,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  labelText: labelText,
                  hintText: hintText,
                  isDense: false,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: suffixIcon,
                  ),
                ),
                validator: (value) {
                  if (disableValidation) {
                    return null;
                  }
                  if (value == null || value.isEmpty) {
                    Fluttertoast.showToast(
                      msg: validatorEmpty ?? '$labelText tidak boleh kosong',
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                    return validatorEmpty ?? '$labelText tidak boleh kosong';
                  }
                  return null;
                },
                obscureText: obscureText,
                textInputAction: textInputAction,
                onFieldSubmitted: onSubmit,
                onTap: onTap,
                initialValue: initialValue,
                readOnly: isReadOnly,
              ),
            ),
            if (satuanText != null && satuanText!.isNotEmpty)
              SizedBox(width: 8.w),
            if (satuanText != null && satuanText!.isNotEmpty) Text(satuanText!),
          ],
        ),
        infoText != null && infoText!.isNotEmpty
            ? Text(infoText!)
            : const SizedBox.shrink(),
        10.verticalSpace,
      ],
    );
  }
}
