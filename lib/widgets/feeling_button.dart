import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_task/config/app_colors.dart';

class FeelingButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String selectedText;

  const FeelingButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.selectedText,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedText == text;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.orangeColor : Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
          style: GoogleFonts.nunito(
            fontSize: 12,
            color: isSelected ? Colors.white : AppColors.blackColor,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}
