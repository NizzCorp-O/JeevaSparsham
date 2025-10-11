import 'package:flutter/material.dart';
import 'package:hello_pratice/features/members/domain/entities/member.dart';

class StatsCard extends StatelessWidget {
  final Member member;
  const StatsCard({super.key,required this.member});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0.5,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "This Month",
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w400,
                color: Color(0xFF2C3E50),
                fontFamily: "Nunito",
              ),
            ),
            SizedBox(height: screenHeight * 0.015),

            // Stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StatItem(
                  value: member.patientsServed.toString(),
                  valueColor: Color(0xFF27AE60), // green
                  label: "Patients Served",
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),

                StatItem(
                  value: "${member.satisfactionRate}%",
                  valueColor: Color(0xFF3498DB), // blue
                  label: "Satisfaction Rate",
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;
  final double screenWidth;
  final double screenHeight;

  const StatItem({
    super.key,
    required this.value,
    required this.label,
    required this.valueColor,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w600,
            fontFamily: "inter",
            color: valueColor,
          ),
        ),
        SizedBox(height: screenHeight * 0.005),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            fontFamily: "inter",
            fontWeight: FontWeight.w400,
            color: Color(0xFF566573),
          ),
        ),
      ],
    );
  }
}



