import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_task/helpers/dialog_helper.dart';
import 'package:test_task/own/custom_track_shape.dart';
import 'package:test_task/widgets/feeling_button.dart';
import 'package:test_task/widgets/mood_button.dart';
import 'package:test_task/widgets/save_button.dart';
import 'package:test_task/widgets/slider_section.dart';

import '../../config/app_colors.dart';
import '../../data/data.dart' show imagePaths, moodFeelings, moodImages;

class MoodDiaryPage extends StatefulWidget {
  const MoodDiaryPage({super.key});

  @override
  State<MoodDiaryPage> createState() => _MoodDiaryPageState();
}

class _MoodDiaryPageState extends State<MoodDiaryPage> {
  double stressLevel = 0.5;
  double selfEsteem = 0.5;
  String selectedMood = "";
  String selectedFeeling = "";
  bool isMoodSelected = false;

  TextEditingController notesController = TextEditingController();

  bool get isFormValid {
    return selectedMood.isNotEmpty &&
        selectedFeeling.isNotEmpty &&
        notesController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Что чувствуешь?",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  moodFeelings.keys.map(
                        (mood) => Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: MoodButton(
                            onTap: () {
                              setState(() {
                                selectedMood = mood;
                                selectedFeeling = "";
                                isMoodSelected = true;
                              });
                            },
                            width: 83,
                            height: 118,
                            paddingVal: 8,
                            text: mood,
                            imageSize: 70,
                            selectedText: selectedMood,
                            imagePath: 'assets/icons/happy1.png',
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),

          if (selectedMood.isNotEmpty) ...[
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  moodFeelings[selectedMood]!
                      .map(
                        (feeling) => FeelingButton(
                          onTap: () {
                            setState(() => selectedFeeling = feeling);
                          },
                          text: feeling,
                          selectedText: selectedFeeling,
                        ),
                      )
                      .toList(),
            ),
          ],
          const SizedBox(height: 20),
          _sliderSection("Уровень стресса", stressLevel, (value) {
            setState(() => stressLevel = value);
          }, isDisabled: !isMoodSelected),
          const SizedBox(height: 30),
          _sliderSection("Самооценка", selfEsteem, (value) {
            setState(() => selfEsteem = value);
          }, isDisabled: !isMoodSelected),
          const SizedBox(height: 20),
          Text("Заметки", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.blackColor),),
          const SizedBox(height: 10),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
          SaveButton(
              onPressed: () {
                if (selectedMood.isNotEmpty && selectedFeeling.isNotEmpty && notesController.text.isNotEmpty) {
                  // success popup
                  DialogHelper.showPopup(context,
                    "Все данные сохранены.\nМуд: $selectedMood\nЧувство: $selectedFeeling\nСтресс: $stressLevel\nСамооценка: $selfEsteem",
                  );
                }
                else {
                  // show error popup
                  DialogHelper.showPopup(
                    context,
                    "Пожалуйста, заполните все поля.",
                  );
                }
              },
            isSelected: isMoodSelected,
          ),
        ],
      ),
    );
  }

  Widget _sliderSection(
    String title,
    double value,
    Function(double) onChanged, {
    required bool isDisabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 10),
        SliderSection(
          minText: "Низкий",
          maxText: "Высокий",
          title: title,
          value: value,
          onChanged: onChanged,
          isDisabled: isDisabled,
        ),
      ],
    );
  }
}
