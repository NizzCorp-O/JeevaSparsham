import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';

class AppSnackbar {
  static void show(context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.backgroundPrimary),
        ),
      ),
    );
  }
}
