import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/presentation/widgets/custome_icons.dart';
import 'package:inventory_management_system/presentation/widgets/custome_linear%20colorgradient.dart';



class CustomeAppbarRow extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final double width;
  final String title;
  final Function() onBackButtonPressed;
  final List<Color> gradientColors;
  final Color backgroundColor;
  final Color? iconColor;

  const CustomeAppbarRow({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.onBackButtonPressed,
    this.gradientColors = const [Colors.blue, Colors.green],
    this.backgroundColor = Colors.black,
    this.iconColor,
  });

  @override
  _CustomeAppbarRowState createState() => _CustomeAppbarRowState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomeAppbarRowState extends State<CustomeAppbarRow> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: widget.backgroundColor,
      automaticallyImplyLeading: false,
      backgroundColor: widget.backgroundColor,
      // Wrapping the Stack in a SizedBox to provide constraints
      title: SizedBox(
        height: kToolbarHeight,  // Use standard AppBar height
        child: Stack(
          children: [
            // Back Button
            Positioned(
              left: 0,
              child: GestureDetector(
                onTap: widget.onBackButtonPressed,
                child: SizedBox(
                  height: widget.height * 0.05,
                  width: widget.width * 0.2,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomGradientIcon(
                      icon: CupertinoIcons.back,
                    ),
                  ),
                ),
              ),
            ),

            // Title
            Positioned.fill(
              child: Center(
                child: CustomeLinearcolor(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  text: widget.title,
                  gradientColors: widget.gradientColors,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
