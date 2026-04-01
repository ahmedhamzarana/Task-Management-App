import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color bglight = Colors.white;
  static const Color primary = Color.fromARGB(255, 174, 52, 15);
  static const Color secondry = Colors.black;

  // Status Colors
  static const Color info = Colors.grey;
  static const Color success = Colors.green;
  static const Color danger = Colors.red;

  // Extended Colors with withAlpha variations
  static Color primaryLight = AppColors.primary.withAlpha(50);
  static Color primaryMedium = AppColors.primary.withAlpha(100);
  static Color primaryDark = AppColors.primary.withAlpha(200);

  static Color successLight = AppColors.success.withAlpha(50);
  static Color successMedium = AppColors.success.withAlpha(100);

  static Color dangerLight = AppColors.danger.withAlpha(50);
  static Color dangerMedium = AppColors.danger.withAlpha(100);

  static Color infoLight = AppColors.info.withAlpha(30);
  static Color infoMedium = AppColors.info.withAlpha(80);

  // Additional utility colors
  static const Color divider = Color.fromARGB(255, 230, 230, 230);
  static const Color shadow = Color.fromARGB(50, 0, 0, 0);
  static const Color overlay = Color.fromARGB(128, 0, 0, 0);
}
