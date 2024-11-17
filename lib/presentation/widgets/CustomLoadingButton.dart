import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;

  const LoadingButton({
    Key? key,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      minWidth: 150.w,
      height: 50.h,
      color: color,
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.black,
          size: 40.sp,
        ),
      ),
    );
  }
}