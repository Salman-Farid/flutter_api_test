import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karmalab_assignment/constants/color_constants.dart';
import 'package:karmalab_assignment/theme/text_theme.dart';

class AppTheme {
  const AppTheme();
  static ThemeData theme() {
    return ThemeData(
      splashColor: AppColors.orange,
      primaryColor: AppColors.white,
      canvasColor: AppColors.white, // Set the canvas color to premium white
      scaffoldBackgroundColor: AppColors.white, // Set the scaffold background to premium white

      primarySwatch: Colors.blue,
      buttonTheme: ButtonThemeData(
          hoverColor: WidgetStateColor.resolveWith((states) => Colors.red),
          ),
      textTheme: TextTheme(
        displaySmall: GoogleFonts.openSans(),
        titleSmall: CustomTextTheme.titleSmall(),
        titleLarge: CustomTextTheme.title(),
        displayMedium: CustomTextTheme.displayMedium(),
        displayLarge: CustomTextTheme.displayLarge(),
      ),
    );
  }
}
