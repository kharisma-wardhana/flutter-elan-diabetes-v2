import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_navigator.dart';
import '../../../core/constant.dart';
import '../../../core/service_locator.dart';
import '../../../gen/assets.gen.dart';
import '../bloc/health_bloc.dart';
import '../bloc/health_state.dart';
import '../widget/glucose_circle_chart.dart';
import '../widget/health_info_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final int glucoseValue = 150;
  final int stepsTaken = 4000;
  final int stepGoal = 5000;

  @override
  void initState() {
    super.initState();
    double targetPercent = (stepsTaken / stepGoal).clamp(0.0, 1.0);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _animation = Tween<double>(
      begin: 0,
      end: targetPercent,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              sl<AppNavigator>().pushNamed(profilePage);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                20.verticalSpace,
                Column(
                  children: [
                    Image.asset(Assets.images.logoElan.path, height: 80.h),
                    16.verticalSpace,
                    Text(
                      'SKRINING KESEHATAN',
                      style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                32.verticalSpace,
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return GlucoseCircleChart(
                      glucoseValue: glucoseValue,
                      progress: _animation.value,
                    );
                  },
                ),
                24.verticalSpace,
                BlocSelector<HealthBloc, HealthState, int>(
                  selector: (state) =>
                      state is HealthSuccess ? state.health.steps : 0,
                  builder: (context, steps) {
                    return HealthInfoRow(
                      icon: Icons.directions_walk,
                      label: "Jumlah Langkah Hari ini",
                      value: "$steps langkah",
                    );
                  },
                ),
                BlocSelector<HealthBloc, HealthState, String>(
                  selector: (state) =>
                      state is HealthSuccess ? state.health.bloodPressure : "-",
                  builder: (context, bloodPressure) {
                    return HealthInfoRow(
                      icon: Icons.monitor_heart,
                      label: "Tekanan Darah",
                      value: "$bloodPressure mmHg",
                    );
                  },
                ),
                HealthInfoRow(
                  icon: Icons.local_fire_department,
                  label: "Jumlah Kalori yang Terbakar",
                  value: "200 kalori",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
