import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/patient_status_card.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.897,
      height: screenHeight * 0.110,
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.tertiary,
        border: Border.all(color: AppColors.borderPrimary, width: 1),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/profile_image.png', width: 40, height: 40),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sarah Johnson',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(fontSize: 14),
              ),
              Text(
                'Chronic Pain Management',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontSize: 12),
              ),
            ],
          ),
          Spacer(),
          PatientStatusCard(
            width: 42,
            height: 16,
            label: 'Active',
            labelColor: Color.fromRGBO(39, 174, 96, 1),
            backgroundColor: Color.fromRGBO(39, 174, 96, 0.1),
          ),
        ],
      ),
    );
  }
}
