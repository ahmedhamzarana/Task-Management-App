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

    if (emailController.text.trim().isEmpty ||
        !emailController.text.contains("@")) {
      emailError = "Valid email required";
      isValid = false;
    } else {
      emailError = "";
    }

    if (passwordController.text.length < 6) {
      passwordError = "Min 6 characters";
      isValid = false;
    } else {
      passwordError = "";
    }

    if (passwordController.text != confirmPasswordController.text) {
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
      // 1. Create User in Supabase Auth
      final AuthResponse res = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = res.user;

      if (user != null) {
        // 2. Insert into your custom table
        // IMPORTANT: Ensure RLS policies in Supabase allow this insert!
        await supabase.from('tbl_users').insert({
          'user_id': user.id,
          'name': usernameController.text.trim(),
          'email': emailController.text.trim(),
          'created_at': DateTime.now().toIso8601String(),
        });

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Registration Successful!"),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
        }
      }
    } on AuthException catch (e) {
      if (context.mounted) {
        _showError(context, e.message);
      }
    } catch (e) {
      if (context.mounted) {
        _showError(context, "Database Error: Make sure RLS policies are set.");
      }
      debugPrint("Detailed Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void _showError(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
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

  void clearControllers() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
