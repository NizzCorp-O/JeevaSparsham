import 'package:flutter/material.dart';
import 'package:hello_pratice/features/auth/presentation/widgets/login_form.dart';
import 'package:hello_pratice/features/auth/presentation/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 247, 244, 1),
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
