import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';

class AppTextStyles {
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w400,
    fontSize: 30,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0,
    color: AppColors.textSecondary,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle bodyMeduim = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 24,
    letterSpacing: 0,
    color: AppColors.quaternary,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0,
    color: Color.fromRGBO(173, 174, 188, 1),
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle headlineSmal = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0,
    color: AppColors.textPrimary,
    overflow: TextOverflow.ellipsis,
  );
}
