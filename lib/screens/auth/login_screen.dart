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
              stops: [0.1, 0.5],
              colors: [AppColors.primary, AppColors.secondry],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Image.asset("assets/logo.png", height: 150),
                SizedBox(height: 70),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      style: TextStyle(color: AppColors.bglight),
                      controller: loginprovider.emailController,
                      cursorColor: AppColors.bglight,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: AppColors.bglight),
                        filled: true,
                        fillColor: AppColors.bglight.withAlpha(25),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors.bglight,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: AppColors.info,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: AppColors.info,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: AppColors.info,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: loginprovider.passwordController,
                      cursorColor: AppColors.bglight,
                      obscureText: loginprovider.isvisbility,
                      style: TextStyle(color: AppColors.bglight),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: AppColors.bglight),
                        filled: true,
                        fillColor: AppColors.bglight.withAlpha(25),
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.bglight,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => loginprovider.isVisiblity(),
                          child: Icon(
                            loginprovider.isvisbility
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.bglight,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: AppColors.info,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: AppColors.info,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: AppColors.info,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              activeColor: AppColors.primary,
                              value: loginprovider.isrememeber,
                              onChanged: (value) => loginprovider.isRemember(),
                            ),
                            Text(
                              "Remember Me",
                              style: TextStyle(color: AppColors.bglight),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: AppColors.bglight),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.bglight,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Login"),
                            SizedBox(width: 7),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont Have An Account",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.registerRoute,
                          ),
                          child: Text(
                            "Register",
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        SizedBox(width: 4),
                        Text("OR", style: TextStyle(color: AppColors.bglight)),
                        SizedBox(width: 4),
                        Expanded(child: Divider()),
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
}
