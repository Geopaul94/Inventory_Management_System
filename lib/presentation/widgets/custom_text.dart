import 'package:flutter/material.dart';


class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final VoidCallback? onTap; // Add onTap callback

  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 16.0,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.onTap, // Initialize onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call onTap when tapped
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}