import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/features/auth/presentation/widgets/login_form.dart';

import 'package:hello_pratice/features/auth/presentation/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [LoginHeader(), SizedBox(height: 50), LoginForm()],
          ),
        ),
      ),
    );
  }
}
