import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../config/app_colors.dart';  // Make sure to define your AppColors

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section for Stress and Self-Esteem Progress
          _progressSection("Уровень стресса", 0.6),
          const SizedBox(height: 20),
          _progressSection("Самооценка", 0.8),

          // Section for Moods Chart
          const SizedBox(height: 40),
          const Text(
            "Распределение настроений",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _moodPieChart(),

          // Section for Mood Change over Time
          const SizedBox(height: 40),
          const Text(
            "Изменение настроения по времени",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _moodChangeLineChart(),

          // Section for Emotion Distribution
          const SizedBox(height: 40),
          const Text(
            "Распределение эмоций",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _emotionBarChart(),
        ],
      ),
    );
  }

  // Progress bar section
  Widget _progressSection(String title, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.blueColor)),
        const SizedBox(height: 10),
        LinearPercentIndicator(
          lineHeight: 14.0,
          percent: value,
          progressColor: Colors.orange,
          backgroundColor: Colors.grey.shade300,
          barRadius: const Radius.circular(10),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }

  // Pie chart for mood distribution
  Widget _moodPieChart() {
    return AspectRatio(
      aspectRatio: 1.5,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: 40,
              title: 'Радость',
              color: Colors.orange,
              radius: 50,
              titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            PieChartSectionData(
              value: 20,
              title: 'Грусть',
              color: Colors.blue,
              radius: 50,
              titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            PieChartSectionData(
              value: 10,
              title: 'Сила',
              color: Colors.green,
              radius: 50,
              titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            PieChartSectionData(
              value: 15,
              title: 'Страх',
              color: Colors.red,
              radius: 50,
              titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            PieChartSectionData(
              value: 15,
              title: 'Бешенство',
              color: Colors.purple,
              radius: 50,
              titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // Line chart for mood changes over time
  Widget _moodChangeLineChart() {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.shade300)),
          minX: 0,
          maxX: 7,
          minY: 0,
          maxY: 1,
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 0.3),
                FlSpot(1, 0.5),
                FlSpot(2, 0.4),
                FlSpot(3, 0.7),
                FlSpot(4, 0.6),
                FlSpot(5, 0.8),
                FlSpot(6, 0.5),
              ],
              isCurved: true,
              barWidth: 4,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: true,color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }

  // Bar chart for emotion distribution
  Widget _emotionBarChart() {
    return AspectRatio(
      aspectRatio: 2,
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(show: false),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: true),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(toY: 10, color: Colors.orange, width: 16),
            ]),
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(toY: 6, color: Colors.blue, width: 16),
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(toY: 8, color: Colors.green, width: 16),
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(toY: 7, color: Colors.red, width: 16),
            ]),
            BarChartGroupData(x: 4, barRods: [
              BarChartRodData(toY: 5, color: Colors.purple, width: 16),
            ]),
          ],
        ),
      ),
    );
  }
}
