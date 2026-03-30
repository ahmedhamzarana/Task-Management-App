// register_provider.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/app_routes.dart';

class RegisterProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  bool isPasswordVisible = false;

  String usernameError = "";
  String emailError = "";
  String passwordError = "";
  String confirmPasswordError = "";

  void togglePassword() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  bool validateForm() {
    bool isValid = true;

    if (usernameController.text.trim().isEmpty) {
      usernameError = "Username required";
      isValid = false;
    } else {
      usernameError = "";
    }

    if (emailController.text.trim().isEmpty) {
      emailError = "Email required";
      isValid = false;
    } else if (!emailController.text.contains("@")) {
      emailError = "Invalid email format";
      isValid = false;
    } else {
      emailError = "";
    }

    if (passwordController.text.isEmpty) {
      passwordError = "Password required";
      isValid = false;
    } else if (passwordController.text.length < 6) {
      passwordError = "Min 6 characters";
      isValid = false;
    } else {
      passwordError = "";
    }

    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError = "Confirm password required";
      isValid = false;
    } else if (passwordController.text != confirmPasswordController.text) {
      confirmPasswordError = "Passwords do not match";
      isValid = false;
    } else {
      confirmPasswordError = "";
    }

    notifyListeners();
    return isValid;
  }

  Future<void> register(BuildContext context) async {
    if (!validateForm()) return;

    isLoading = true;
    notifyListeners();

    try {
      final response = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = response.user;
      if (user == null) throw Exception("Signup failed");

      await supabase.from("tbl_users").insert({
        "id": user.id,
        "username": usernameController.text.trim(),
        "email": emailController.text.trim(),
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration successful"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
      }
    } on AuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}