import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final Color backgroundColor;
  final void Function() onTap;
  const CustomButton({
    super.key,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color.fromRGBO(229, 231, 235, 1)),
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
