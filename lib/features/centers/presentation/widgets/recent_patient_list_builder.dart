import 'package:flutter/material.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/patient_card.dart';

class RecentPatientListBuilder extends StatelessWidget {
  const RecentPatientListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return PatientCard();
      },
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10),
    );
  }
}
