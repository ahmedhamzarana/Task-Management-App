// login_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final supabase = Supabase.instance.client;

  bool isloading = false;
  bool isvisbility = true; // Default to obscured
  bool isrememeber = false;
  
  String emailError = "";
  String passwordError = "";

  // Logic: if isvisbility is true, obscureText should be true
  void toggleVisibility() {
    isvisbility = !isvisbility;
    notifyListeners();
  }

  void toggleRemember() {
    isrememeber = !isrememeber;
    notifyListeners();
  }

  // Load saved data if "Remember Me" was used last time
  Future<void> loadRememberedCredentials() async {
    String? savedEmail = await storage.read(key: "email");
    String? savedPass = await storage.read(key: "password");
    if (savedEmail != null && savedPass != null) {
      emailController.text = savedEmail;
      passwordController.text = savedPass;
      isrememeber = true;
      notifyListeners();
    }
  }

  bool formValidate() {
    emailError = "";
    passwordError = "";
    bool isValid = true;

    if (emailController.text.trim().isEmpty) {
      emailError = "Email is required";
      isValid = false;
    } else if (!emailController.text.contains("@")) {
      emailError = "Invalid email format";
      isValid = false;
    }

    if (passwordController.text.isEmpty) {
      passwordError = "Password is required";
      isValid = false;
    }

    notifyListeners();
    return isValid;
  }

  Future<void> login(BuildContext context) async {
    if (!formValidate()) return;

    isloading = true;
    notifyListeners();

    try {
      await supabase.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Handle Secure Storage
      if (isrememeber) {
        await storage.write(key: "email", value: emailController.text.trim());
        await storage.write(key: "password", value: passwordController.text.trim());
      } else {
        await storage.delete(key: "email");
        await storage.delete(key: "password");
      }

      if (context.mounted) {
        emailController.clear();
        passwordController.clear();
        Navigator.pushReplacementNamed(context, "/appmainRoute");
      }
    } on AuthException catch (e) {
      // Catch specific Supabase errors
      if (e.message.contains("Invalid login credentials")) {
        emailError = "Invalid email or password";
      } else {
        emailError = e.message;
      }
    } catch (e) {
      emailError = "An unexpected error occurred";
    } finally {
      isloading = false;
      notifyListeners();
    }
  }
}