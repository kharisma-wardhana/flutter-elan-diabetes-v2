import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/colors.gen.dart';
import 'custom_loading.dart';

class BasePage extends StatefulWidget {
  final Widget body;
  final Color? bgColor;
  final bool isLoading;
  final PreferredSizeWidget? appBar;
  final Widget? drawable;

  const BasePage({
    super.key,
    required this.body,
    this.bgColor = ColorName.white,
    this.isLoading = false,
    this.appBar,
    this.drawable,
  });

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: widget.bgColor,
          resizeToAvoidBottomInset: false,
          appBar: widget.appBar,
          drawer: widget.drawable,
          body: Stack(
            children: [
              Padding(padding: EdgeInsets.all(8.r), child: widget.body),
              if (widget.isLoading)
                Positioned.fill(child: const CustomLoading()),
            ],
          ),
        ),
      ),
    );
  }
}
