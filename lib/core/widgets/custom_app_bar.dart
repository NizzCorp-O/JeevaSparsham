import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar(this.title, {super.key});

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
          color: AppColors.textPrimary,
          onSelected: (value) {},
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'settings', child: Text('Settings')),
            const PopupMenuItem(value: 'logout', child: Text('Logout')),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
