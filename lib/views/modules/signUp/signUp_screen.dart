// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghino_gas_flutter/views/modules/signUp/signUp_viewModel.dart';
import '../../../res/colors.dart';
import '../../../res/text_style.dart';
import '../../../utilis/utilis.dart';
import '../../widgets/button/round_button.dart';
import '../../widgets/widgetCompomentLess.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _controller = Get.put(SignUpController());

  final _emailFN = FocusNode();
  final _passwordFN = FocusNode();
  final _confirmPassFN = FocusNode();
  final _displayNameFN = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroudApp,
        body: SingleChildScrollView(
          padding: WidgetLess.edgeInsetSplitScreen(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Đăng ký tài khoản",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Quản lý nợ mà không tốn giấy ghi ngay!",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              _listTextFormField(context),
              const SizedBox(
                height: 30,
              ),
              RoundButton(
                onPressed: () async {
                  _controller.signUp(context);
                },
                title: "Sign Up",
                textStyle: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: TextStyleApp.fontSize),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn đã có tài khoản ?",
                    style: TextStyle(
                      fontSize: TextStyleApp.fontSize,
                      decoration: TextDecoration.underline,
                      color: const Color(0xff0D0E0E),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Login ngay",
                        style: TextStyle(
                          fontSize: TextStyleApp.fontSize,
                          color: AppColors.blue0E64D2,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _listTextFormField(BuildContext context) {
    var _visibilityPassword = true.obs;
    var _visibilityConfirmPassword = true.obs;
    return Obx(
      () => Column(
        children: [
          TextFormField(
            controller: _controller.ctrlUserName,
            focusNode: _displayNameFN,
            onFieldSubmitted: (value) {
              Utils.fieldFocusChange(context, _displayNameFN, _emailFN);
            },
            decoration: InputDecoration(
                hintText: "Nhập tên người dùng",
                labelText: "Username",
                labelStyle: TextStyle(fontSize: TextStyleApp.fontSize),
                hintStyle: TextStyle(fontSize: TextStyleApp.fontSize),
                errorText: _controller.errorUserName,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: _controller.ctrlEmail,
            focusNode: _emailFN,
            onFieldSubmitted: (value) {
              Utils.fieldFocusChange(context, _emailFN, _passwordFN);
            },
            decoration: InputDecoration(
                hintText: "Nhập Email của bạn",
                labelText: "Email",
                labelStyle: TextStyle(fontSize: TextStyleApp.fontSize),
                hintStyle: TextStyle(fontSize: TextStyleApp.fontSize),
                errorText: _controller.errorEmail,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: _controller.ctrlPassword,
            focusNode: _passwordFN,
            obscureText: _visibilityPassword.value,
            onFieldSubmitted: (value) {
              Utils.fieldFocusChange(context, _passwordFN, _confirmPassFN);
            },
            decoration: InputDecoration(
                hintText: "Nhập mật khẩu",
                labelText: "Mật khẩu",
                labelStyle: TextStyle(fontSize: TextStyleApp.fontSize),
                hintStyle: TextStyle(fontSize: TextStyleApp.fontSize),
                errorText: _controller.errorPassword,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  onPressed: () {
                    _visibilityPassword.value = !_visibilityPassword.value;
                  },
                  icon: _visibilityPassword.value
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.visibility_outlined),
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: _controller.ctrlConfirmPassword,
            focusNode: _confirmPassFN,
            obscureText: _visibilityConfirmPassword.value,
            decoration: InputDecoration(
                hintText: "Xác nhận mật khẩu",
                labelText: "Xác nhận",
                labelStyle: TextStyle(fontSize: TextStyleApp.fontSize),
                hintStyle: TextStyle(fontSize: TextStyleApp.fontSize),
                errorText: _controller.errorConfirmPassword,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  onPressed: () {
                    _visibilityConfirmPassword.value =
                        !_visibilityConfirmPassword.value;
                  },
                  icon: _visibilityConfirmPassword.value
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.visibility_outlined),
                )),
          ),
        ],
      ),
    );
  }
}
