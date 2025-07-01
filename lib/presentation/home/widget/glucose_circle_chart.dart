import 'package:flutter/material.dart';

import 'circle_chart_painter.dart';

class GlucoseCircleChart extends StatelessWidget {
  final int glucoseValue;
  final double progress; // antara 0.0 - 1.0

  const GlucoseCircleChart({
    super.key,
    required this.glucoseValue,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(200, 200),
            painter: CircleChartPainter(progress),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gula Darah',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                '$glucoseValue',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text('mg/dL', style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
