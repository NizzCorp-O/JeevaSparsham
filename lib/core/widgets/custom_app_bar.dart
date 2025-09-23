import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        'Palliative Care Centers',
        style: Theme.of(
          context,
        ).textTheme.headlineLarge?.copyWith(fontSize: 20),
      ),
      actions: [Icon(Icons.more_vert, size: 26, color: AppColors.textPrimary)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
