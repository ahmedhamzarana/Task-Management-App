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
              crossAxisAlignment: CrossAxisAlignment.center,
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

                    // EMAIL
                    TextField(
                      style: const TextStyle(color: AppColors.bglight),
                      controller: loginprovider.emailController,
                      cursorColor: AppColors.bglight,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: const TextStyle(color: AppColors.bglight),
                        filled: true,
                        fillColor: AppColors.bglight.withAlpha(25),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: AppColors.bglight,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: AppColors.bglight.withAlpha(100),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: AppColors.bglight.withAlpha(100),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: AppColors.bglight.withAlpha(100),
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // PASSWORD
                    TextField(
                      controller: loginprovider.passwordController,
                      cursorColor: AppColors.bglight,
                      obscureText: loginprovider.isvisbility,
                      style: const TextStyle(color: AppColors.bglight),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(color: AppColors.bglight),
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
                            color: AppColors.bglight.withAlpha(100),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: AppColors.bglight.withAlpha(100),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: AppColors.bglight.withAlpha(100),
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // REMEMBER + FORGOT
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              activeColor: AppColors.primary,
                              checkColor: AppColors.bglight,
                              value: loginprovider.isrememeber,
                              onChanged: (value) => loginprovider.isRemember(),
                            ),
                            const Text(
                              "Remember Me",
                              style: TextStyle(color: AppColors.bglight),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: AppColors.bglight),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // LOGIN BUTTON
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

                    const SizedBox(height: 20),

                    // REGISTER LINK
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Dont Have An Account",
                          style: TextStyle(color: AppColors.bglight),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.registerRoute,
                          ),
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // OR DIVIDER
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.bglight.withAlpha(100),
                            thickness: 2,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          "OR",
                          style: TextStyle(color: AppColors.bglight),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Divider(
                            color: AppColors.bglight.withAlpha(100),
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.bglight,
                              foregroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {},
                            icon: Image.asset("assets/logo.png", height: 20),
                            label: const Text("Google"),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.bglight,
                              foregroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () {},
                            icon: Image.asset("assets/logo.png", height: 20),
                            label: const Text("Facebook"),
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
}
