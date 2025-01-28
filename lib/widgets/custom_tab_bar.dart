import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_task/config/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  final VoidCallback onTap;
  final int tabIndex;
  final int selectedIndex;
  final IconData icon;
  final String text;

  const CustomTabBar({
    super.key,
    required this.onTap,
    required this.selectedIndex,
    required this.tabIndex,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedIndex == tabIndex; 

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.orangeColor : AppColors.lightGreyColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.greyColor,
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: GoogleFonts.nunito(
                color: isSelected ? Colors.white : AppColors.greyColor,
                fontSize: 12,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ),
    );
  }
}
