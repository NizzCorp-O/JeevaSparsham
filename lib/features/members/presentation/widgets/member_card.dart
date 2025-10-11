import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/features/members/application/bloc/members_bloc.dart';
import 'package:hello_pratice/features/members/application/bloc/members_event.dart';

class MemberCard extends StatelessWidget {
  final String name;
  final String phone;
  final String role;
  final Color roleColor;
  final String avatarUrl;
  final VoidCallback? onTap;

  const MemberCard({
    super.key,
    required this.name,
    required this.phone,
    required this.role,
    required this.roleColor,
    required this.avatarUrl,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0.5,
        child: Padding(
          padding:  EdgeInsets.all(screenWidth * 0.03),
          child: Row(
            children: [
              CircleAvatar(
                radius: screenWidth * 0.07,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: avatarUrl.isNotEmpty
                    ? NetworkImage(avatarUrl)
                    : null,
                child: avatarUrl.isEmpty
                    ?  Icon(
                        Icons.person,
                        size: screenWidth * 0.07,
                        color: Colors.grey,
                      ) // Placeholder icon
                    : null,
              ),
               SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:  TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      phone,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: screenWidth * 0.035),
                    ),
                     SizedBox(height: screenHeight * 0.005),
                    Container(
                      padding:  EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.025,
                        vertical: screenHeight * 0.004,
                      ),
                      decoration: BoxDecoration(
                        color: roleColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        role,
                        style: TextStyle(
                          color: roleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.03,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               SizedBox(width: screenWidth * 0.02),
              GestureDetector(
                onTap: () {
                  context.read<MemberBloc>().add(CallMember(phone));
                },
                child: CircleAvatar(
                  radius: screenWidth * 0.05,
                  backgroundColor: Colors.blue,
                  child:  Icon(Icons.phone, color: Colors.white, size: screenWidth * 0.04),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
