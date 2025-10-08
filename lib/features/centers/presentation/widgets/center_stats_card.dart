import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';

class CenterStatsCard extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;
  final double width;
  final double height;

  const CenterStatsCard({
    super.key,
    required this.value,
    required this.label,
    required this.valueColor,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.tertiary,
        border: Border.all(color: AppColors.borderPrimary, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: valueColor),
          ),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
