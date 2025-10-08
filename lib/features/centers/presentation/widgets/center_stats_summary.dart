import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/center_stats_card.dart';

class CenterStatsSummary extends StatelessWidget {
  const CenterStatsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary Stats',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 18),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            CenterStatsCard(
              width: screenWidth * 0.45,
              height: screenHeight * 0.13,
              value: '247',
              label: 'Total Patients',
              valueColor: AppColors.secondary,
            ),
            SizedBox(width: 20),
            CenterStatsCard(
              width: screenWidth * 0.4,
              height: screenHeight * 0.13,
              value: '34',
              label: 'Active Patients',
              valueColor: Color.fromRGBO(93, 173, 226, 1),
            ),
          ],
        ),
      ],
    );
  }
}
