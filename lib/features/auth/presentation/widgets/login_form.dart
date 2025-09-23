import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/core/app_snackbar.dart';
import 'package:hello_pratice/core/widgets/custom_button.dart';
import 'package:hello_pratice/features/auth/application/bloc/auth_bloc.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';
import 'package:hello_pratice/features/centers/presentation/screens/centers_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.885,
      height: screenHeight * 0.500,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: AppColors.primary,
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username', style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 15),
            TextFormField(
              controller: _usernameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username cannot be empty';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter your username',
                prefixIcon: Icon(
                  size: 24,
                  Icons.person,
                  color: Color.fromRGBO(170, 183, 184, 1),
                ),
              ),
            ),

            SizedBox(height: 30),
            Text('Password', style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 15),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscureText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password cannot be empty';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter your password',

                prefixIcon: Icon(
                  size: 24,
                  Icons.lock,
                  color: Color.fromRGBO(170, 183, 184, 1),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: _obscureText
                    ? Icon(
                          size: 20,
                          Icons.visibility_off,
                          color: Color.fromRGBO(170, 183, 184, 1),
                        ): Icon(
                          size: 20,
                          Icons.visibility,
                          color: Color.fromRGBO(170, 183, 184, 1),
                        )
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      AppSnackbar.show(context, message: state.message);
                      context.read<CenterBloc>().add(GetAllCentersEvent());
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CentersScreen(),
                        ),
                      );
                    } else if (state is LoginError) {
                      AppSnackbar.show(context, message: state.message);
                    }
                  },
                  builder: (BuildContext context, AuthState state) {
                    bool isLoading = state is LoginLoading;
                    return (isLoading
                        ? CircularProgressIndicator()
                        : CustomButton(
                            width: screenWidth * 0.778,
                            height: screenHeight * 0.059,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  LoginRequested(
                                    email: _usernameController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ),
                                );

                                _usernameController.clear();
                                _passwordController.clear();
                              }
                            },
                            backgroundColor: AppColors.quaternary,
                            label: 'Sign In',
                          ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
