import 'package:flutter/material.dart';

import '../../gen/colors.gen.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.black26,
      child: const Center(
        child: CircularProgressIndicator(color: ColorName.primary),
      ),
    );
  }
}
