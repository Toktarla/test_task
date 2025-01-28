import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class MoodButton extends StatelessWidget {

  final VoidCallback onTap;
  final double width;
  final double height;
  final double paddingVal;
  final String text;
  final String selectedText;
  final String imagePath;
  final double imageSize;
  const MoodButton({super.key, required this.onTap, required this.width, required this.height, required this.paddingVal, required this.text, required this.selectedText, required this.imagePath, required this.imageSize});

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedText == text;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(paddingVal),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: isSelected ? AppColors.orangeColor : Colors.transparent, width: 1.5),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
              BoxShadow(
                  color: AppColors.lightGreyColor,
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3),
              )
          ]
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: imageSize,
                  width: imageSize,
                  child: Image.asset(imagePath)
              ),
              const SizedBox(height: 5),
              Text(
                text,
                style: const TextStyle(fontSize: 11),
                softWrap: false,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
