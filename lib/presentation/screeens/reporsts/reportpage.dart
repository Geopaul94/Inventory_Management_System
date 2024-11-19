import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class Reportpage extends StatelessWidget {
  const Reportpage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: "Reports",
        backgroundColor: blue,
        isTitleBold: true,
      ),
      body: Center(
    
        child: Text("data"),
      ),
    );
  }
}
