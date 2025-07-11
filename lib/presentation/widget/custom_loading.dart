import 'package:flutter/material.dart';

import '../../gen/colors.gen.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withValues(alpha: 0.8),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // penting agar tidak memenuhi layar
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: ColorName.primary),
            SizedBox(height: 16), // beri jarak antar widget
            Text('Mohon tunggu...', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
