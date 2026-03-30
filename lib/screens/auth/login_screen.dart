// login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/login_provider.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/utils/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginprovider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.5],
              colors: [AppColors.primary, AppColors.secondry],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png", height: 150),
                const SizedBox(height: 70),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        color: AppColors.bglight,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // --- EMAIL ---
                    TextField(
                      style: const TextStyle(color: AppColors.bglight),
                      controller: loginprovider.emailController,
                      cursorColor: AppColors.bglight,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: const TextStyle(color: AppColors.bglight),
                        filled: true,
                        // SHOW ERROR HERE
                        errorText: loginprovider.emailError.isEmpty ? null : loginprovider.emailError,
                        fillColor: AppColors.bglight.withAlpha(25),
                        prefixIcon: const Icon(Icons.email_outlined, color: AppColors.bglight),
                        border: _buildBorder(),
                        enabledBorder: _buildBorder(),
                        focusedBorder: _buildBorder(),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // --- PASSWORD ---
                    TextField(
                      controller: loginprovider.passwordController,
                      cursorColor: AppColors.bglight,
                      obscureText: loginprovider.isvisbility,
                      style: const TextStyle(color: AppColors.bglight),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(color: AppColors.bglight),
                        filled: true,
                        // SHOW ERROR HERE
                        errorText: loginprovider.passwordError.isEmpty ? null : loginprovider.passwordError,
                        fillColor: AppColors.bglight.withAlpha(25),
                        prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.bglight),
                        suffixIcon: GestureDetector(
                          onTap: () => loginprovider.toggleVisibility(),
                          child: Icon(
                            loginprovider.isvisbility
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.bglight,
                          ),
                        ),
                        border: _buildBorder(),
                        enabledBorder: _buildBorder(),
                        focusedBorder: _buildBorder(),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // --- REMEMBER + FORGOT ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              activeColor: AppColors.primary,
                              side: const BorderSide(color: AppColors.bglight),
                              checkColor: AppColors.bglight,
                              value: loginprovider.isrememeber,
                              onChanged: (value) => loginprovider.toggleRemember(),
                            ),
                            const Text("Remember Me", style: TextStyle(color: AppColors.bglight)),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Forgot Password?", style: TextStyle(color: AppColors.bglight)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // --- LOGIN BUTTON ---
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.bglight,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: loginprovider.isloading ? null : () => loginprovider.login(context),
                        child: loginprovider.isloading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(color: AppColors.bglight, strokeWidth: 2),
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Login"),
                                  SizedBox(width: 7),
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // --- REGISTER LINK ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Dont Have An Account", style: TextStyle(color: AppColors.bglight)),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, AppRoutes.registerRoute),
                          child: const Text(
                            "Register",
                            style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // --- OR DIVIDER ---
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.bglight.withAlpha(100), thickness: 2)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("OR", style: TextStyle(color: AppColors.bglight)),
                        ),
                        Expanded(child: Divider(color: AppColors.bglight.withAlpha(100), thickness: 2)),
                      ],
                    ),

                    const SizedBox(height: 10),
                    
                    // --- SOCIAL LOGINS ---
                    Row(
                      children: [
                        Expanded(
                          child: _socialButton("Google", "assets/logo.png"), // Replace with google icon
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _socialButton("Facebook", "assets/logo.png"), // Replace with fb icon
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

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide(color: AppColors.bglight.withAlpha(100), width: 2),
    );
  }

  Widget _socialButton(String label, String asset) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.bglight,
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: () {},
      icon: Image.asset(asset, height: 20),
      label: Text(label),
    );
  }
}