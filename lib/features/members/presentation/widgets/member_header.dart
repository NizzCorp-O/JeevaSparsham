import 'package:flutter/material.dart';

import 'package:hello_pratice/features/members/domain/entities/member.dart';

class MemberHeader extends StatelessWidget {
  final Member member;
  const MemberHeader({super.key,required this.member});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        CircleAvatar(
          radius: screenWidth * 0.12,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: member.avatarUrl.isNotEmpty
              ? NetworkImage(member.avatarUrl)
              : null,
          child: member.avatarUrl.isEmpty
              ? Icon(Icons.person, size: screenWidth * 0.12)
              : null,
          
        ),
        SizedBox(height: screenHeight * 0.015),
        Text(
          member.name,
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.035,
            vertical: screenHeight * 0.007,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            member.role,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: screenWidth * 0.04,
            ),
          ),
        ),
      ],
    );
  }
}
