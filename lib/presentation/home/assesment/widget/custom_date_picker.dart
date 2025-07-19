import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../gen/colors.gen.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController controller;

  const CustomDatePicker({super.key, required this.controller});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            textTheme: const TextTheme(),
            colorScheme: const ColorScheme.light(
              primary: Colors.teal, // Warna tema utama
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: Colors.white,
            ), // Warna latar belakang
          ),
          child: Container(child: child!),
        );
      },
    );
    if (picked != null) {
      setState(() {
        widget.controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: 60.h,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: ColorName.darkGrey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  widget.controller.text.isEmpty
                      ? 'Tanggal'
                      : widget.controller.text,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
        16.verticalSpace,
      ],
    );
  }
}
