import 'package:flutter/material.dart';
import 'package:gps_tracker/presentation/misc/colors.dart';
import 'package:gps_tracker/presentation/misc/typography.dart';

class UgCommandTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  const UgCommandTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.textInputAction,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction ?? TextInputAction.done,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Typogaphy.Regular.copyWith(
          color: AppColors.secondarySoft,
          fontSize: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryExtraSoft),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryExtraSoft),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: 1.2),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}
