import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/presentation/screeens/authentication/login_page.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';

import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Call the method to check user sign-in status
    _checkUserSignIn(context);

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Center(
            child: Lottie.asset('assets/animation/inventory_animation.json'),
          ),
        ),
      ),
    );
  }

  void _checkUserSignIn(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5));
    // Check if the user is signed in
    User? user = FirebaseAuth.instance.currentUser;

    // If user is signed in, navigate to HomePage
    if (user != null) {
      // Optionally, you can save the sign-in status in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreens()),
      );
    } else {
      // If user is not signed in, navigate to LoginPage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }
}
