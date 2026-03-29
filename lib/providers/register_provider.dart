import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterProvider extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassWordController = TextEditingController();

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

  void validateForm(){
    bool isValid = true;
    if(passwordController.text != confirmPassWordController.text){
      isValid = false;
    }
    if(!isValid){
      // Show an error message or handle the validation failure
      print("Passwords do not match");
    } else {
      // Proceed with registration logic
      print("Form is valid, proceed with registration");  
    }
  }
}
