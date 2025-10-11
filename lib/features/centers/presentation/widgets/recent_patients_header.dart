import 'package:flutter/material.dart';

class RecentPatientsHeader extends StatelessWidget {
  const RecentPatientsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Patients',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 18),
        ),
        Text(
          'View All',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 14,
            color: Color.fromRGBO(93, 173, 226, 1),
          ),
        ),
      ],
    );
  }
}
