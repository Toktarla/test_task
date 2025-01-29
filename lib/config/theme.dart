import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';


// Не стал делать, так как неудобно дебажить (-hot reload)
var theme = ThemeData(
  textTheme: GoogleFonts.nunitoSansTextTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.backgroundColor,
    titleTextStyle: GoogleFonts.nunito(
      color: AppColors.greyColor,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  ),
  scaffoldBackgroundColor: AppColors.backgroundColor,
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(),
);
