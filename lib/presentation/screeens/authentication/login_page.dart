import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/login_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/login_event.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_management_system/presentation/screeens/authentication/signup_page.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';
import 'package:inventory_management_system/presentation/widgets/custom_elevated_button.dart';
import 'package:inventory_management_system/presentation/widgets/custom_text.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   //   appBar: AppBar(title: const Text('Login')),
      body: BlocProvider(
        create: (_) => LoginBloc(FirebaseAuth.instance),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return const CircularProgressIndicator();
              } else if (state is LoginFailure) {
                return Text('Error: ${state.error}', style: const TextStyle(color: Colors.red));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            onChanged: (value) => context.read<LoginBloc>().add(EmailChanged(value)),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            onChanged: (value) => context.read<LoginBloc>().add(PasswordChanged(value)),
          ),
          const SizedBox(height: 20),
         




 CustomGradientButton(
  text: 'Log in ',
  onPressed: () {
    context.read<LoginBloc>().add(const LoginSubmitted());

             Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreens(),
      ),
    );
  },
  width: 250, 
  height: 60, 
  fontSize: 18, 
  fontWeight: FontWeight.bold, 
  gradientColors: [Colors.blue, Colors.purple], 
),





Row(children: [
CustomText(
  text: '''Don't have any account then Sign up ''',
  fontSize: 12, 
  color: Colors.black, 
  fontWeight: FontWeight.normal, 
),


CustomText(

  onTap: () {

    Navigator.push(

      context,

      MaterialPageRoute(builder: (context) => SignUpScreen()), 

    );

  },
  text: '''Sign up ''',
  fontSize: 20, 
  color: Colors.green, 
  fontWeight: FontWeight.bold,
),
],)
        ],
      ),
    );
  }
}
