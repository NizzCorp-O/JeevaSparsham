import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/core/app_text_styles.dart';

class AppInputThemes {
  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.transparent,
    hintStyle: AppTextStyles.bodyLarge.copyWith(
      color: Color.fromRGBO(173, 174, 188, 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.borderSecondary, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.borderSecondary, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.borderSecondary, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.borderSecondary, width: 1),
    ),
  );
}
