import 'package:flutter/material.dart';
import 'package:gps_tracker/presentation/misc/colors.dart';
import 'package:gps_tracker/presentation/misc/screen.dart';
import 'package:gps_tracker/presentation/misc/typography.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color? color;
  final bool fullwidth;
  const CustomButton({
    super.key,
    this.onPressed,
    required this.title,
    this.color,
    this.fullwidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (fullwidth == true) ? AppScreens.width : null,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.secondary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.secondary),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          title,
          style: Typogaphy.Medium,
        ),
      ),
    );
  }
}
