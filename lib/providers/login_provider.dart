import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isloading = false;
  bool isvisbility = false;
  bool isrememeber = false;

  void isVisiblity() {
    isvisbility = !isvisbility;
    notifyListeners();
  }

  void isRemember() {
    isrememeber = !isrememeber;
    notifyListeners();
  }
}