import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';

class PatientStatusCard extends StatelessWidget {
  final double width;
  final double height;
  final String label;
  final Color labelColor;
  final Color backgroundColor;
  const PatientStatusCard({
    super.key,
    required this.width,
    required this.height,
    required this.label,
    required this.labelColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(9999)),
        color: backgroundColor,
        border: Border.all(color: AppColors.borderSecondary, width: 1),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontSize: 12, color: labelColor),
      ),
    );
  }
}
