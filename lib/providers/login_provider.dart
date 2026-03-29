import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FlutterSecureStorage storage = FlutterSecureStorage();

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