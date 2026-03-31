import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task_management_app/utils/app_routes.dart';

class SplashProvider extends ChangeNotifier {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  void splashTimer(BuildContext context) async {
    if (await storage.containsKey(key: "email") &&
        await storage.containsKey(key: "password")) {
      await Future.delayed(const Duration(seconds: 3));
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
