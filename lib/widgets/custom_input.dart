import 'package:flutter/material.dart';
import 'package:task_management_app/utils/app_colors.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.ErrorText,
  });

  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? ErrorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: AppColors.bglight,
      style: const TextStyle(color: AppColors.bglight),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.bglight),
        errorText: ErrorText,
        filled: true,
        fillColor: AppColors.bglight.withAlpha(25),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border:  OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(color: AppColors.info, width: 2),
    ),
        enabledBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(color: AppColors.info, width: 2),
    ),
        focusedBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(color: AppColors.info, width: 2),
    ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
      ),
    );
  }
}
