import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/signup_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/signup_event.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/signup_state.dart';
import 'package:inventory_management_system/presentation/screeens/authentication/login_page.dart';
import 'package:inventory_management_system/presentation/widgets/custom_elevated_button.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sign Up'),
      ),
      body: BlocProvider(
        create: (_) => SignUpBloc(FirebaseAuth.instance),
        child: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                if (state is SignUpLoading) {
                  return const CircularProgressIndicator();
                } else if (state is SignUpFailure) {
                  return Text('Error: ${state.error}',
                      style: const TextStyle(color: Colors.red));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Username'),
              onChanged: (value) =>
                  context.read<SignUpBloc>().add(UsernameChanged(value)),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) =>
                  context.read<SignUpBloc>().add(EmailChanged(value)),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
              onChanged: (value) =>
                  context.read<SignUpBloc>().add(PhoneChanged(value)),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) =>
                  context.read<SignUpBloc>().add(PasswordChanged(value)),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              onChanged: (value) =>
                  context.read<SignUpBloc>().add(ConfirmPasswordChanged(value)),
            ),
            const SizedBox(height: 20),
            CustomGradientButton(
              text: 'Sign up ',
              onPressed: () {
                //  context.read<LoginBloc>().add(const LoginSubmitted());

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              width: 250,
              height: 60,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              gradientColors: [Colors.blue, Colors.purple],
            ),
          ],
        ),
      ),
    );
  }
}
