import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/patient_status_card.dart';

class RecentPatientListBuilder extends StatelessWidget {
  const RecentPatientListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          width: screenWidth * 0.897,
          height: screenHeight * 0.110,
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppColors.backgroundPrimary,
            border: Border.all(color: AppColors.borderPrimary, width: 1),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/profile_image.png',
                width: 40,
                height: 40,
              ),
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
                    ).textTheme.headlineLarge?.copyWith(fontSize: 12),
                  ),
                ],
              ),
              Spacer(),
              PatientStatusCard(
                width: 52.171875,
                height: 24,
                label: 'Active',
                labelColor: Color.fromRGBO(39, 174, 96, 1),
                backgroundColor: Color.fromRGBO(39, 174, 96, 0.1),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10),
    );
  }
}
