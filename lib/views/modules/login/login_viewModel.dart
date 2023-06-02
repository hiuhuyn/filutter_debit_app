import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utilis/routers/routes_name.dart';
import '../../../utilis/utilis.dart';
import '../../../data/auth.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  RxBool _visibilityPassword = true.obs;
  RxString _errorEmail = "".obs;
  RxString _errorPassword = "".obs;
  String get errorEmail => _errorEmail.value;
  String get errorPassword => _errorPassword.value;
  bool get visibilityPassword => _visibilityPassword.value;

  setVisibilityPassword() {
    _visibilityPassword.value = !_visibilityPassword.value;
  }

  Future signInGoogle() async {
    try {
      await Auth.signInWithGoogle().then((value) {
        if (value != null) {
          Get.offAllNamed(RoutesName.home);
        } else {
          Utils.toastMessage("User: null");
        }
      });
    } on FirebaseAuthException catch (e) {
      print("Error signInGoogle: ${e}");
      // Auth.signOut();
      Utils.toastMessage("Error signInGoogle: ${e}");
    }
  }

  Future signInWithEmailAndPassword() async {
    try {
      if (emailController.text.isEmpty) {
        _errorEmail.value = "Hãy nhập đầy đủ email!";
        return;
      }
      _errorEmail.value = "";
      if (passwordController.text.length < 6 ||
          passwordController.text.isEmpty) {
        _errorPassword.value = "Mật khẩu chứa tối thiểu 6 ký tự";
        return;
      }
      _errorPassword.value = "";
      await Auth.signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        Get.offAllNamed(RoutesName.home);
      });
    } on FirebaseAuthException catch (e) {
      print("Error signInWithEmailAndPassword: $e");
      if (e.code == 'user-not-found') {
        _errorEmail.value = "Email chưa được đăng ký!";
      } else if (e.code == 'wrong-password') {
        _errorPassword.value = 'Mật khẩu chưa chính xác.';
      } else if (e.code == "invalid-email") {
        _errorEmail.value = "Địa chỉ email bị định dạng sai.";
      } else {
        print(
            "Error FirebaseAuthException: \ncode:${e.code}\nMessage: ${e.message}");
      }
      return;
    }
  }
}
