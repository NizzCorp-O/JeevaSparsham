import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/icons/login_illustration.svg",
          height: 80,
          width: 80,
        ),
        SizedBox(height: 20),
        Text('Welcome Back', style: Theme.of(context).textTheme.headlineLarge),
        SizedBox(height: 10),
        Text(
          'Sign in to continue',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
