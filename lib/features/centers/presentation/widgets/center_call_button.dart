import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';

class CenterCallButton extends StatelessWidget {
  final String phoneNumber;
  const CenterCallButton(this.phoneNumber, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.897,
      height: screenHeight * 0.070,
      decoration: BoxDecoration(
        color: AppColors.quaternary,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Color.fromRGBO(229, 231, 235, 1), width: 1),
      ),
      child: InkWell(
        onTap: () {
          context.read<CenterBloc>().add(MakePhoneCallEvent("555 123-4567"));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.call, color: AppColors.backgroundPrimary),
            SizedBox(width: 5),
            Text(
              'Call $phoneNumber',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.backgroundPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
