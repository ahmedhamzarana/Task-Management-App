import 'package:flutter/material.dart';
import 'package:task_management_app/utils/app_colors.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    // Shared border style to match your Scheduler UI
    final OutlineInputBorder commonBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12), // Changed from 50 to 12
      borderSide: const BorderSide(
        color: Color(0xFFE9ECEF), // Matches the Scheduler border color
        width: 1.0,
      ),
    );

    return TextField(
      controller: controller,
      cursorColor: AppColors.primary,
      maxLines: maxLines,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFADB5BD), // Matches your previous UI hint color
          fontSize: 14,
        ),
        errorText: errorText,
        filled: true,
        fillColor: Colors.white, // Matches Scheduler background
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        
        // Borders updated to match the Scheduler style
        border: commonBorder,
        enabledBorder: commonBorder,
        focusedBorder: commonBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}