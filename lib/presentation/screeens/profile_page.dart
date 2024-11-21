import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/data/repository/authentication/auth_service.dart';
import 'package:inventory_management_system/presentation/screeens/authentication/login_page.dart';
import 'package:inventory_management_system/presentation/widgets/custom_elevated_button.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ListView(
        children: [h100,h100,
          Center(
            child: CustomGradientButton(text: "Logout", onPressed:() {
                  AuthService().signOut(context); 
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
            }, gradientColors: [AppColors.primaryColor,Colors.green]),
          )
        ],
      )),
    );
  }
}