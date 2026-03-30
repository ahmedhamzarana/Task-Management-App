import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/register_provider.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/utils/app_routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerprovider = Provider.of<RegisterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary.withAlpha(100),
        title: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: AppColors.bglight),
        ),
      ),
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
                      "Register",
                      style: TextStyle(
                        color: AppColors.bglight,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: registerprovider.usernameController,
                      cursorColor: AppColors.bglight,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: TextStyle(color: AppColors.bglight),

                        filled: true,
                        fillColor: Colors.white.withAlpha(25),
                        prefixIcon: Icon(
                          Icons.person_outlined,
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
                      controller: registerprovider.emailController,
                      cursorColor: AppColors.bglight,
                      style: TextStyle(color: AppColors.bglight),
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
                      controller: registerprovider.passwordController,
                      cursorColor: AppColors.bglight,
                      obscureText: registerprovider.isvisbility,
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
                          onTap: () => registerprovider.isVisiblity(),
                          child: Icon(
                            registerprovider.isvisbility
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
                    const SizedBox(height: 20),
                    TextField(
                      style: TextStyle(color: AppColors.bglight),
                      controller: registerprovider.confirmPassWordController,
                      cursorColor: AppColors.bglight,
                      obscureText: registerprovider.isvisbility,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(color: AppColors.bglight),

                        filled: true,
                        fillColor: AppColors.bglight.withAlpha(25),
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: AppColors.bglight,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => registerprovider.isVisiblity(),
                          child: Icon(
                            registerprovider.isvisbility
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
                            Text("Register"),
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
                          "Do You Have An Account",
                          style: TextStyle(color: AppColors.bglight),
                        ),
                        SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.loginRoute,
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(color: AppColors.primary),
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
