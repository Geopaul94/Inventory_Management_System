import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData? leadingIcon;
  final IconData? cupertinoLeadingIcon;
  final double? leadingIconSize;
  final double? leadingIconPadding;
  final String title;
  final TextStyle? titleStyle;
  final bool centerTitle;
  final bool? backarrow; // Optional bool for back arrow (defaults to false)
  final bool isTitleBold;
  final Color backgroundColor;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final List<Widget>? actions; // New parameter for actions

  const CustomAppBar({
    super.key,
    this.leadingIcon,
    this.backgroundColor = Colors.blue,  // Set default background color
    this.cupertinoLeadingIcon,
    this.titleFontSize,
    this.titleFontWeight,
    this.leadingIconSize,
    this.leadingIconPadding,
    required this.title,
    this.titleStyle,
    this.centerTitle = true,
    this.isTitleBold = false,
    this.backarrow = false, this.actions, // Default backarrow to false
  }); // Removed required for showBackArrow

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      leading: backarrow != null && backarrow!
          ? IconButton(
              icon: const Icon(CupertinoIcons.back),color: white,
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Text(
        title,
        style: titleStyle ??
            TextStyle(
              fontSize: titleFontSize ?? MediaQuery.of(context).size.width * 0.055,
              fontWeight: isTitleBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.white,  // Set text color to white
            ),
      ),
      centerTitle: centerTitle,
      actions: actions, // Add actions to the AppBar
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}