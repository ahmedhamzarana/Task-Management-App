import 'package:flutter/material.dart';
import 'package:task_management_app/screens/app_main_screen.dart';
import 'package:task_management_app/screens/auth/forgot_password_screen.dart';
import 'package:task_management_app/screens/auth/login_screen.dart';
import 'package:task_management_app/screens/auth/register_screen.dart';
import 'package:task_management_app/screens/auth/splash_screen.dart';

class AppRoutes {
  static const String splashRoute = "/";
  static const String appmainRoute = "/appmainRoute";
  static const String loginRoute = "/loginRoute";
  static const String registerRoute = "/registerRoute";
  static const String forgotPasswordRoute = "/forgotPasswordRoute";

  static final Map<String, WidgetBuilder> routes = {
    splashRoute: (_) => const SplashScreen(),
    loginRoute: (_) => const LoginScreen(),
    registerRoute: (_) => const RegisterScreen(),
    appmainRoute: (_) => const AppMainScreen(),
    forgotPasswordRoute: (_) => const ForgotPasswordScreen(),
  };
}
