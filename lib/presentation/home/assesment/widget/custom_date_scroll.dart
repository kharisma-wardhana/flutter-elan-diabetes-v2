import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../../gen/colors.gen.dart';

class CustomDateScroll extends StatefulWidget {
  final Function onChanged;

  const CustomDateScroll({super.key, required this.onChanged});

  @override
  State<CustomDateScroll> createState() => _CustomDateScrollState();
}

class _CustomDateScrollState extends State<CustomDateScroll> {
  final ScrollController _scrollController = ScrollController();
  final double itemWidth = 60.w;
  DateTime selectedDate = DateTime.now();
  List<String> months = [];
  List<DateTime> days = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id').then((_) {
      setState(() {
        months = List.generate(
          12,
          (index) => DateFormat('MMMM', 'id').format(DateTime(0, index + 1)),
        );
      });
      updateDays();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToIndex(selectedDate.day);
    });
  }

  void updateDays() {
    int daysInMonth = DateUtils.getDaysInMonth(
      selectedDate.year,
      selectedDate.month,
    );
    days = List.generate(
      daysInMonth,
      (index) => DateTime(selectedDate.year, selectedDate.month, index + 1),
    );
  }

  void _scrollToIndex(int index) {
    // Calculate the offset
    double offset = index * itemWidth;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: DropdownButton<String>(
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, size: 50.h),
                value: months.isEmpty
                    ? null
                    : DateFormat('MMMM', 'id').format(selectedDate),
                items: months.map((String month) {
                  return DropdownMenuItem<String>(
                    value: month,
                    child: Text(
                      '$month ${selectedDate.year}',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDate = DateTime(
                      selectedDate.year,
                      months.indexOf(newValue!) + 1,
                    );
                    updateDays();
                    _scrollToIndex(0);
                  });
                  widget.onChanged(selectedDate);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: days.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  alignment: Alignment.center,
                  width: itemWidth,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    color: days[index].day == selectedDate.day
                        ? Colors.green
                        : ColorName.lightGrey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('E', 'id').format(days[index]), // Weekday
                        style: TextStyle(
                          color: days[index].day == selectedDate.day
                              ? Colors.white
                              : Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        days[index].day.toString(), // Date
                        style: TextStyle(
                          color: days[index].day == selectedDate.day
                              ? Colors.white
                              : Colors.black,
                          fontWeight: days[index].day == selectedDate.day
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  widget.onChanged(days[index]);
                  setState(() {
                    selectedDate = days[index];
                    _scrollToIndex(selectedDate.day);
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
