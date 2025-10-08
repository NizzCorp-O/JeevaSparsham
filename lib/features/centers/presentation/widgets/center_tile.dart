import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hello_pratice/core/app_colors.dart';

class CenterTile extends StatelessWidget {
  final String icon;
  final String name;
  final String location;
  final void Function()? onTap;

  const CenterTile({
    super.key,
    required this.icon,
    required this.name,
    required this.location,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.130,
      padding: EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.tertiary,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: AppColors.borderPrimary, width: 1),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
            color: Color.fromRGBO(0, 0, 0, 0.05),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SvgPicture.asset(icon, width: 48, height: 48),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.labelLarge),
                  Text(
                    location,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ),
            Icon(
              size: 30,
              Icons.chevron_right_rounded,
              color: Color.fromRGBO(170, 183, 184, 1),
            ),
          ],
        ),
      ),
    );
  }
}
