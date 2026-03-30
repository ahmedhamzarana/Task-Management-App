// register_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/register_provider.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/utils/app_routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to changes to update error UI
    final registerprovider = Provider.of<RegisterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.bglight),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight:
                MediaQuery.of(context).size.height -
                AppBar().preferredSize.height,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.5],
              colors: [AppColors.primary, AppColors.secondry],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png", height: 150),
                const SizedBox(height: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Register",
                      style: TextStyle(
                        color: AppColors.bglight,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // --- Username Field ---
                    TextField(
                      controller: registerprovider.usernameController,
                      cursorColor: AppColors.bglight,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: const TextStyle(color: AppColors.bglight),
                        errorText: registerprovider.usernameError.isEmpty
                            ? null
                            : registerprovider.usernameError,
                        filled: true,
                        fillColor: Colors.white.withAlpha(25),
                        prefixIcon: const Icon(
                          Icons.person_outlined,
                          color: AppColors.bglight,
                        ),
                        border: _buildOutlineBorder(),
                        enabledBorder: _buildOutlineBorder(),
                        focusedBorder: _buildOutlineBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- Email Field ---
                    TextField(
                      controller: registerprovider.emailController,
                      cursorColor: AppColors.bglight,
                      style: const TextStyle(color: AppColors.bglight),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: const TextStyle(color: AppColors.bglight),
                        errorText: registerprovider.emailError.isEmpty
                            ? null
                            : registerprovider.emailError,
                        filled: true,
                        fillColor: AppColors.bglight.withAlpha(25),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: AppColors.bglight,
                        ),
                        border: _buildOutlineBorder(),
                        enabledBorder: _buildOutlineBorder(),
                        focusedBorder: _buildOutlineBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- Password Field ---
                    TextField(
                      controller: registerprovider.passwordController,
                      cursorColor: AppColors.bglight,
                      obscureText: !registerprovider.isPasswordVisible,
                      style: const TextStyle(color: AppColors.bglight),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(color: AppColors.bglight),
                        errorText: registerprovider.passwordError.isEmpty
                            ? null
                            : registerprovider.passwordError,
                        filled: true,
                        fillColor: AppColors.bglight.withAlpha(25),
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.bglight,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => registerprovider.togglePassword(),
                          icon: Icon(
                            registerprovider.isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.bglight,
                          ),
                        ),
                        border: _buildOutlineBorder(),
                        enabledBorder: _buildOutlineBorder(),
                        focusedBorder: _buildOutlineBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- Confirm Password Field ---
                    TextField(
                      controller: registerprovider.confirmPasswordController,
                      cursorColor: AppColors.bglight,
                      obscureText: !registerprovider.isPasswordVisible,
                      style: const TextStyle(color: AppColors.bglight),
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        hintStyle: const TextStyle(color: AppColors.bglight),
                        errorText: registerprovider.confirmPasswordError.isEmpty
                            ? null
                            : registerprovider.confirmPasswordError,
                        filled: true,
                        fillColor: AppColors.bglight.withAlpha(25),
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.bglight,
                        ),
                        border: _buildOutlineBorder(),
                        enabledBorder: _buildOutlineBorder(),
                        focusedBorder: _buildOutlineBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // --- Register Button ---
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.bglight,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () => registerprovider.register(context),
                        child: registerprovider.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.bglight,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Register"),
                                  SizedBox(width: 7),
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- Login Link ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Do You Have An Account",
                          style: TextStyle(color: AppColors.bglight),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.loginRoute,
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper to keep code clean and maintain your UI style
  OutlineInputBorder _buildOutlineBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(color: AppColors.info, width: 2),
    );
  }
}
