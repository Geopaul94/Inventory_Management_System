import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_management_system/data/models/user_data_model.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/signup_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/signup_event.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/signup_state.dart';
import 'package:inventory_management_system/presentation/screeens/authentication/login_page.dart';
import 'package:inventory_management_system/presentation/widgets/custom_elevated_button.dart';
import 'package:inventory_management_system/presentation/widgets/customanimation_explore_page_loading.dart';
import 'package:inventory_management_system/presentation/widgets/custometextformfield.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  final TextEditingController _ConfirmPassowrdController =
      TextEditingController();
  final TextEditingController _ShopNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is LoadingState) {
            isloading = true;
          } else if (state is SignupSuccessedState) {
            Navigator.of(context).pushAndRemoveUntil(
                (MaterialPageRoute(builder: (context) => LoginScreen())),
                (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: BlocProvider(
              create: (_) => SignUpBloc(),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          if (state is SignUpLoading) {
                            return const SpinningLinesExample();
                          } else if (state is SignUpFailure) {
                            return Text('Error: ${state.error}',
                                style: const TextStyle(color: Colors.red));
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Shop Name'),
                        controller: _ShopNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your shop name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Phone'),
                        keyboardType: TextInputType.phone,
                        controller: _phonenumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        controller: _PasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Confirm Password'),
                        controller: _ConfirmPassowrdController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _PasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomGradientButton(
                        text: isloading ? 'Waiting' : 'Sign up ',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Trigger sign-up event
                            // context.read<SignUpBloc>().add(SignUpSubmitted(
                            //       email: _emailController.text,
                            //       password: _PasswordController.text,
                            //       phone: _phonenumberController.text,
                            //       shopName: _ShopNameController.text,
                            //     ));

                            UserModel model = UserModel(
                                shopename: _ShopNameController.text,
                                email: _emailController.text,
                                password: _PasswordController.text,
                                phonenumber: _phonenumberController.text);
                            context
                                .read<SignUpBloc>()
                                .add(OnsignUpButtonClickedEvent(user: model));
                          }
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
              ),
            ),
          );
        },
      ),
    );
  }
}
