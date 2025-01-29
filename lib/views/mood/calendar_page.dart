import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:test_task/extensions/string_extension.dart';
import 'package:test_task/helpers/calendar_helper.dart';
import 'package:test_task/views/mood/year_picker_page.dart';

import '../../config/app_colors.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat('d MMMM yyyy', 'ru_RU').format(_selectedDate),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.greyColor),
            ),
          ),
        ],
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(12, (monthIndex) {
            return _buildMonthCalendar(monthIndex);
          }),
        ),
      ),
    );
  }

  Widget _buildMonthCalendar(int monthIndex) {
    DateTime firstDayOfMonth = DateTime(_selectedDate.year, monthIndex + 1, 1);
    int numberOfDaysInMonth = CalendarHelper.getNumberOfDaysInMonth(firstDayOfMonth);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          // Month Name and Year
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => YearPickerPage(initialDate: _selectedDate)));
              },
              child: Text(
                '${DateFormat('yyyy', 'ru_RU').format(firstDayOfMonth)} Click It!',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.greyColor),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              DateFormat('MMMM', 'ru_RU').format(firstDayOfMonth).capitalize(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.blackColor),
            ),
          ),
          // Days of the week row
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('ПН', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.greyColor)),
                Text('ВТ', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.greyColor)),
                Text('СР', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.greyColor)),
                Text('ЧТ', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.greyColor)),
                Text('ПТ', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.greyColor)),
                Text('СБ', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.greyColor)),
                Text('ВС', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.greyColor)),
              ],
            ),
          ),
          // Calendar grid (days of the month)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
            ),
            itemCount: numberOfDaysInMonth + CalendarHelper.getStartDayOfMonth(firstDayOfMonth),
            itemBuilder: (context, index) {
              if (index < CalendarHelper.getStartDayOfMonth(firstDayOfMonth)) {
                // Empty space before the 1st day of the month
                return Container();
              } else {
                DateTime day = DateTime(firstDayOfMonth.year, firstDayOfMonth.month, index - CalendarHelper.getStartDayOfMonth(firstDayOfMonth) + 1);
                bool isToday = day.isAtSameMomentAs(DateTime.now());
                bool isSelected = day.isAtSameMomentAs(_selectedDate);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = day;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.orangeColor.withOpacity(0.4)
                          : isToday
                          ? Colors.greenAccent
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${day.day}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blueColor
                          ),
                        ),
                        if (isSelected)
                          Container(
                            width: 6.0,
                            height: 6.0,
                            decoration: BoxDecoration(
                              color: AppColors.orangeColor,
                              shape: BoxShape.circle,
                            ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
