import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/login_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/login_event.dart';
import 'package:inventory_management_system/presentation/screeens/authentication/signup_page.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';
import 'package:inventory_management_system/presentation/widgets/CustomLoadingButton.dart';
import 'package:inventory_management_system/presentation/widgets/custom_elevated_button.dart';
import 'package:inventory_management_system/presentation/widgets/custom_text.dart';
import 'package:inventory_management_system/presentation/widgets/custometextformfield.dart';

import 'package:inventory_management_system/utilities/constants/constants.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => LoginBloc(FirebaseAuth.instance, GoogleSignIn()),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return LoadingButton(onPressed: () {}, color: blue);
                } else if (state is LoginFailure) {
                  return Text('Error: ${state.error}', style: const TextStyle(color: Colors.red));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            CustomTextFormField(
              labelText: "Email",
              icon: CupertinoIcons.text_bubble,
              controller: _emailController,
            ),

            SizedBox(height: 10,),
            CustomTextFormField(
              labelText: "Password",
              icon: CupertinoIcons.lock,
              controller: _passwordController,
            ),
            const SizedBox(height: 20),
            CustomGradientButton(
              text: 'Log in',
              onPressed: () {
                context.read<LoginBloc>().add(LoginSubmitted(
                  _emailController.text,
                  _passwordController.text,
                ));
              },
              width: 250,
              height: 60,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              gradientColors: [Colors.blue, Colors.purple],
            ),
            const SizedBox(height: 20),
            CustomGradientButton(
              text: 'Log in with Google',
              onPressed: () {
                context.read<LoginBloc>().add(GoogleLoginSubmitted());
              },
              width: 250,
              height: 60,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              gradientColors: [Colors.red, Colors.orange],
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: "Don't have an account? Sign up",
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(height: 5),
                CustomText(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  text: "Sign up",
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
