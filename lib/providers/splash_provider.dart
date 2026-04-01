import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task_management_app/utils/app_routes.dart';

class SplashProvider extends ChangeNotifier {
  void splashTimer(BuildContext context) async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    String? email = await storage.read(key: "useremail");
    await Future.delayed(const Duration(seconds: 3));
    if (email != null && email.isNotEmpty) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.appmainRoute);
      }
    } else {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
      }
    }
  }
}
