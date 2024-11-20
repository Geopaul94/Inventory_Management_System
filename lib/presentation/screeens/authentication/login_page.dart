import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/login_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/login_event.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/login_state.dart';
import 'package:inventory_management_system/presentation/screeens/authentication/signup_page.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';
import 'package:inventory_management_system/presentation/widgets/custom_elevated_button.dart';
import 'package:inventory_management_system/presentation/widgets/custom_text.dart';
import 'package:inventory_management_system/presentation/widgets/customanimation_explore_page_loading.dart';
import 'package:inventory_management_system/presentation/widgets/custome_snackbar.dart';
import 'package:inventory_management_system/presentation/widgets/custometextformfield.dart';
import 'package:inventory_management_system/presentation/widgets/validations.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/images/inventro.png'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "Email"),
                    CustomTextFormField(
                      labelText: "Email",
                      icon: CupertinoIcons.mail,
                      controller: _emailController,
                      validator: validateEmail,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: "Password",
                      fontWeight: FontWeight.bold,
                    ),
                    CustomTextFormField(
                      labelText: "Password",
                      icon: CupertinoIcons.lock,
                      controller: _passwordController,
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
                  ],
                ),
                h20,
                BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                  if (state is LoginLoadingState) {
                    return CircularProgressIndicator();
                  } else if (state is LoginErrorState) {
                    customSnackbar(context, state.error, red);
                  } else if (state is LoginSuccessState) {
                    // Schedule the snackbar and navigation to happen after the current frame
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      customSnackbar(context, 'Logged In Successfully', green);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return MainScreens(initialIndex: 0);
                      }));
                    });
                  }

                  return CustomGradientButton(
                    text: 'Log in',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(LoginSubmittedEvent(
                              _emailController.text,
                              _passwordController.text,
                            ));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreens(
                                initialIndex: 0,
                              ),
                            ));
                      }
                    },
                    width: 250,
                    height: 60,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    gradientColors: const [Colors.blue, Colors.purple],
                  );
                }),
                const SizedBox(height: 20),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LogingoogleButtonLoadingState) {
                      return const CircularProgressIndicator();
                    }
                    return GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/g_logo.png',
                            width: 0.12.sw,
                            height: 0.07.sh,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 0.02.sw,
                          ),
                          const Text("Sign in with Google"),
                        ],
                      ),
                      onTap: () async {
                        //    context.read<LoginBloc>().add(GoogleLoginSubmitted());

                        print("google button pressed");
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: "Don't have an account? ",
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(width: 5),
                    CustomText(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
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
        ),
      ),
    ));
  }
}
