import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final List<Color> gradientColors;
  final VoidCallback onPressed;

  const CustomGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 200,
    this.height = 50,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: Colors.white, 
          ),
        ),
      ),
    );
  }
}