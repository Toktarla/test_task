import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:test_task/extensions/string_extension.dart';

import '../../config/app_colors.dart';
import '../../helpers/calendar_helper.dart';

class YearPickerPage extends StatefulWidget {
  final DateTime initialDate;

  const YearPickerPage({Key? key, required this.initialDate}) : super(key: key);

  @override
  _YearPickerPageState createState() => _YearPickerPageState();
}

class _YearPickerPageState extends State<YearPickerPage> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.greyColor,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat('d MMMM yyyy', 'ru_RU').format(_selectedDate),
              style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.greyColor),
            ),
          ),
        ],
        backgroundColor: AppColors.backgroundColor,
      ),

      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          int year = DateTime.now().year + index;
          return _buildYear(year);
        },
      ),
    );
  }

  Widget _buildYear(int year) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '$year',
                style: GoogleFonts.nunito(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.blueColor),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: 12,
              itemBuilder: (context, monthIndex) {
                DateTime firstDayOfMonth = DateTime(year, monthIndex + 1, 1);
                bool isSelected = _selectedDate.month == monthIndex + 1 &&
                    _selectedDate.year == year;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = DateTime(year, monthIndex + 1, 1);
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('MMMM', 'ru_RU').format(firstDayOfMonth).capitalize(),
                          style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.blueColor),
                        ),
                        _buildMonthDays(firstDayOfMonth),
                    ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthDays(DateTime monthStartDate) {
    int numberOfDaysInMonth = CalendarHelper.getNumberOfDaysInMonth(monthStartDate);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.7,
      ),
      itemCount: numberOfDaysInMonth,
      itemBuilder: (context, index) {
        DateTime day = DateTime(monthStartDate.year, monthStartDate.month, index + 1);
        bool isSelected = day.isAtSameMomentAs(_selectedDate);

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = day;
            });
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${day.day}',
              style: GoogleFonts.nunito(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : AppColors.blueColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
