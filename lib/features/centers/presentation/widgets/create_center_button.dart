import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';

// ignore: must_be_immutable
class CreateCenterButton extends StatelessWidget {
  void Function()? onTap;
  CreateCenterButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      width: screenWidth * 0.9275,
      height: screenHeight * 0.0893,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(color: AppColors.borderPrimary, width: 1),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: screenWidth * 0.8493,
          height: screenHeight * 0.0650,
          decoration: BoxDecoration(
            color: Color.fromRGBO(170, 183, 184, 1),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: AppColors.borderSecondary, width: 1),
          ),
          child: Text(
            'Create Center',
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppColors.tertiary),
          ),
        ),
      ),
    );
  }
}
