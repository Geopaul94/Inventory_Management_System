import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

// Custom button with ScreenUtil
MaterialButton customButton({
  required String buttonText,
  required VoidCallback onPressed,
  required Color color,
}) {
  return MaterialButton(
    onPressed: onPressed,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)), // Use ScreenUtil for radius
    minWidth: ScreenUtil().screenWidth, // Use full screen width
    height: 0.06.h, // Use 6% of screen height
    color: color,
    child: Text(buttonText),
  );
}

// Loading button with ScreenUtil
MaterialButton loadingButton({
  required VoidCallback onPressed,
  required Color gradientStartColor,
  required Color gradientEndColor,
  required Color loadingIndicatorColor,
  double? width,
  double? height,
}) {
  return MaterialButton(
    onPressed: onPressed,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
    minWidth: width ?? ScreenUtil().screenWidth, // Use provided width or full screen width
    height: height ?? 0.06.h, // Use provided height or 6% of screen height
    padding: EdgeInsets.zero,
    child: Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gradientStartColor, gradientEndColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        alignment: Alignment.center,
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: loadingIndicatorColor,
          size: 40.sp, // Use ScreenUtil for size
        ),
      ),
    ),
  );
}