import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/auth.dart';
import '../../../utilis/utilis.dart';

class SignUpController extends GetxController {
  final ctrlUserName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  final ctrlConfirmPassword = TextEditingController();
  final _errorConfirmPassword = "".obs;
  final _errorEmail = "".obs;
  final _errorUserName = "".obs;
  final _errorPassword = "".obs;

  String? get errorConfirmPassword {
    if (_errorConfirmPassword.value.isEmpty) {
      return null;
    }
    return _errorConfirmPassword.value;
  }

  String? get errorEmail {
    if (_errorEmail.value.isEmpty) {
      return null;
    }
    return _errorEmail.value;
  }

  String? get errorUserName {
    if (_errorUserName.value.isEmpty) {
      return null;
    }
    return _errorUserName.value;
  }

  String? get errorPassword {
    if (_errorPassword.value.isEmpty) {
      return null;
    }
    return _errorPassword.value;
  }

  bool _isCheckErrorSignUp() {
    if (ctrlUserName.text.isEmpty) {
      _errorUserName.value = "Tên không được bỏ trống";
      return true;
    }
    _errorUserName.value = "";
    if (ctrlEmail.text.isEmpty) {
      _errorEmail.value = "Email không được bỏ trống";
      return true;
    }
    _errorEmail.value = "";
    if (ctrlPassword.text.isEmpty) {
      _errorPassword.value = "Password không được bỏ trống";
      return true;
    }
    if (ctrlPassword.text.length < 6) {
      _errorPassword.value = "Password tối thiểu 6 kí tự";
      return true;
    }
    _errorPassword.value = "";

    if (ctrlConfirmPassword.text.isEmpty) {
      _errorConfirmPassword.value = "Bạn chưa xác nhận mật khẩu";
      return true;
    }
    if (ctrlConfirmPassword.text != ctrlPassword.text) {
      _errorConfirmPassword.value = "Xác nhận mật khẩu không thành công!";
      return true;
    }
    _errorConfirmPassword.value = "";

    return false;
  }

  Future signUp(BuildContext context) async {
    try {
      if (!_isCheckErrorSignUp()) {
        if (await Auth.isEmailRegistered(ctrlEmail.text)) {
          _errorEmail.value = "Email đã tồn tại!";
        } else {
          _errorEmail.value = "";
          var userCredential = await Auth.createUserWithEmailAndPassword(
              email: ctrlEmail.text,
              password: ctrlPassword.text,
              displayName: ctrlUserName.text);
          userCredential.user?.sendEmailVerification().then((value) {
            Auth.signOut();
            Utils.alertdialog(
                context: context,
                title: "Thông báo",
                content:
                    "Link xác nhận email đã được gửi đến ${ctrlEmail.text.trim()} của bạn.",
                onClickCancel: () {},
                onClickOk: () {
                  Get.back();
                });
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      print("Error create account\nCode:${e.code}\nMessage: ${e.message}");
      if (e.code == "invalid-email") {
        _errorEmail.value = "Địa chỉ email bị định dạng sai.";
      } else {
        _errorEmail.value = "";
      }
    } catch (e) {
      print(e);
    }
  }
}
