import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/features/members/presentation/screens/member_detail_screen.dart';
import 'package:hello_pratice/features/members/presentation/screens/members_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  CustomAppBar(this.title, {super.key});

  final memberId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 20),
      ),
      actions: [
        PopupMenuButton<String>(
          color: AppColors.tertiary,
          onSelected: (value) {},
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'M Details',
              child: Text('M Details'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MemberDetailScreen(memberId: memberId),
                  ),
                );
              },
            ),
            PopupMenuItem(
              value: 'Members',
              child: Text( 'Members'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MembersPage()),
                );
              },
            ),
            
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
