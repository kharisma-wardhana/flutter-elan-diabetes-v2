import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant.dart';
import '../widget/onboarding_yesno_card.dart';
import '../widget/question_card.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _onboardingCards = [
    OnboardingYesnoCard(
      title: 'Apakah Anda memiliki riwayat Diabetes?',
      optionA: 'Ya',
      optionB: 'Tidak',
      onTapA: () {
        _pageController.animateToPage(
          _pageController.initialPage + 1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceInOut,
        );
      },
      onTapB: () {
        _pageController.animateToPage(
          _pageController.initialPage + 1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceInOut,
        );
      },
    ),
    QuestionCard(questions: questions),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('ELAN')),
        body: Padding(
          padding: EdgeInsets.all(8.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: _onboardingCards,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
