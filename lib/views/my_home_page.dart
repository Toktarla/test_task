import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_task/views/mood/calendar_page.dart';
import 'package:test_task/helpers/date_format_helper.dart';
import 'package:test_task/views/mood/mood_diary_page.dart';
import 'package:test_task/views/stats/statistics_page.dart';
import 'package:test_task/widgets/custom_tab_bar.dart';
import '../config/app_colors.dart';

class MyHomePage extends StatelessWidget {

  MyHomePage({super.key});

  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  void _onContainerTapped(int index) {
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormatHelper.getCurrentDateInRussian(),
          style: GoogleFonts.nunito(
            color: AppColors.greyColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarPage()),
              );
            },
            icon: Icon(
              Icons.calendar_month,
              color: AppColors.greyColor,
              size: 24,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder<int>(
                valueListenable: _selectedIndex,
                builder: (context, selectedIndex, child) {
                  return CustomTabBar(
                      tabIndex: 0,
                      onTap: () => _onContainerTapped(0),
                      selectedIndex: selectedIndex,
                      icon: Icons.sticky_note_2_outlined,
                      text: 'Дневник Настроения',
                  );
                },
              ),
              ValueListenableBuilder<int>(
                valueListenable: _selectedIndex,
                builder: (context, selectedIndex, child) {
                  return CustomTabBar(
                    tabIndex: 1,
                    onTap: () => _onContainerTapped(1),
                    selectedIndex: selectedIndex,
                    icon: Icons.bar_chart_sharp,
                    text: 'Статистика',
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: _selectedIndex,
              builder: (context, selectedIndex, child) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IndexedStack(
                    index: selectedIndex,
                    children: const [
                      MoodDiaryPage(),
                      StatsPage(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
