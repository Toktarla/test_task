import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_task/own/custom_thump_shape.dart';

import '../config/app_colors.dart';
import '../own/custom_track_shape.dart';

class SliderSection extends StatelessWidget {
  final String minText;
  final String maxText;
  final String title;
  final double value;
  final Function(double) onChanged;
  final bool isDisabled;

  const SliderSection({super.key, required this.minText, required this.maxText, required this.title, required this.value, required this.onChanged, required this.isDisabled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) => Text("|",
                    style: GoogleFonts.nunito(fontSize: 18, color: AppColors.greyColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    thumbColor: isDisabled ? AppColors.greyColor : AppColors.orangeColor,
                    activeTrackColor: isDisabled ? AppColors.lightGreyColor : AppColors.orangeColor,
                    inactiveTrackColor: AppColors.lightGreyColor,
                    trackHeight: 4,
                    trackShape: CustomTrackShape(),
                    thumbShape: CustomThumbShape()
                ),
                child: Slider(
                  value: value,
                  onChanged: isDisabled ? null : onChanged,
                  min: 0,
                  max: 1,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                    child: Text(
                      minText,
                      style: GoogleFonts.nunito(fontSize: 14, color: AppColors.blueColor),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0, bottom: 8.0),
                    child: Text(
                      maxText,
                      style: GoogleFonts.nunito(fontSize: 14, color: AppColors.blueColor),
                    ),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}
