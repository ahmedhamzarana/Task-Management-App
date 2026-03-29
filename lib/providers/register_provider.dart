
import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassWordController = TextEditingController();

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

  void validateForm(){
    if(passwordController == confirmPassWordController){
      
    }
  }
}
