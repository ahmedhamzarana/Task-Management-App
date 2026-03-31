import 'package:flutter/material.dart';
import 'package:task_management_app/screens/app_main_screen.dart';
import 'package:task_management_app/screens/auth/login_screen.dart';
import 'package:task_management_app/screens/auth/register_screen.dart';
import 'package:task_management_app/screens/auth/splash_screen.dart';

class AppRoutes {
  static const String splashRoute = "/";
  static const String appmainRoute = "/appmainRoute";
  static const String loginRoute = "/loginRoute";
  static const String registerRoute = "/registerRoute";
  static const String fogotPasswordRoute = "/fogotPasswordRoute";

  static Map<String, WidgetBuilder> routes = {
    splashRoute: (_) => SplashScreen(),
    loginRoute: (_) => LoginScreen(),
    registerRoute: (_) => RegisterScreen(),
    appmainRoute: (_) => AppMainScreen(),
  };
}
