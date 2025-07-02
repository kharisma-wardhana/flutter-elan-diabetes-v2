import 'package:elan/core/app_navigator.dart';
import 'package:elan/core/constant.dart';
import 'package:elan/presentation/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/service_locator.dart';

class QuestionCard extends StatefulWidget {
  final List<String> questions;

  const QuestionCard({super.key, required this.questions});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  List<String> answers = [];
  List<bool> isAnswered = [];

  @override
  void initState() {
    super.initState();
    isAnswered = List<bool>.filled(widget.questions.length, false);
    answers = List<String>.filled(widget.questions.length, '');
  }

  void _updateAnswer(int index, String value) {
    setState(() {
      answers[index] = value;
      isAnswered[index] = true;
    });
  }

  bool get allAnswered => isAnswered.every((e) => e);
  bool get hasAtLeastTwoYes =>
      answers.where((answer) => answer == 'Ya').length >= 2;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.questions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.questions[index],
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    8.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Radio<String>(
                          value: 'Ya',
                          groupValue: answers[index],
                          onChanged: (value) => _updateAnswer(index, value!),
                        ),
                        Text('Ya', style: TextStyle(fontSize: 16.sp)),
                        Radio<String>(
                          value: 'Tidak',
                          groupValue: answers[index],
                          onChanged: (value) => _updateAnswer(index, value!),
                        ),
                        Text('Tidak', style: TextStyle(fontSize: 16.sp)),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        if (allAnswered)
          CustomButton(
            isLoading: isLoading,
            textButton: "Lanjutkan",
            onTap: () {
              setState(() {
                isLoading = true;
              });
              // Aksi ketika next ditekan
              if (hasAtLeastTwoYes) {
                sl<AppNavigator>().pushNamed(gulaDarahPage);
              } else {
                sl<AppNavigator>().pushNamed(
                  recommendationPage,
                  arguments: recommendations['normal'],
                );
              }
              setState(() {
                isLoading = false;
              });
            },
          ),
      ],
    );
  }
}
