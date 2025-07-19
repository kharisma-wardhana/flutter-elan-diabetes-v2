import 'package:elan/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widget/custom_button.dart';
import '../../../widget/custom_text_field.dart';

class CustomTimePicker extends StatefulWidget {
  final TextEditingController controller;

  const CustomTimePicker({super.key, required this.controller});

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    // final TimeOfDay? picked = await showTimePicker(
    //   context: context,
    //   initialTime: TimeOfDay.now(),
    //   builder: (BuildContext context, Widget? child) {
    //     return Container(
    //       child: child!,
    //     );
    //   },
    // );
    // if (picked != null) {
    //   setState(() {
    //     widget.controller.text = picked.format(context);
    //   });
    // }
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueGrey[50],
          ),
          height: 500,
          child: Column(
            children: [
              Text('Pilih Waktu'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: hourController,
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        if (val.isNotEmpty && int.parse(val) > 24) {
                          hourController.text = '24';
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      controller: minuteController,
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        if (val.isNotEmpty && int.parse(val) > 59) {
                          minuteController.text = '59';
                        }
                      },
                    ),
                  ),
                ],
              ),
              CustomButton(
                textButton: 'Selesai',
                onTap: () {
                  setState(() {
                    widget.controller.text =
                        '${hourController.text} : ${minuteController.text}';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _selectTime(context);
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
                      ? 'Jam'
                      : widget.controller.text,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
