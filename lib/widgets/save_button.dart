import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_colors.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isSelected;

  const SaveButton({super.key, required this.onPressed, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? AppColors.orangeColor : AppColors.greyColor,
          ),
          child: Text(
            "Сохранить",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
