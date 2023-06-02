import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghino_gas_flutter/res/colors.dart';
import 'package:ghino_gas_flutter/res/text_style.dart';
import 'package:ghino_gas_flutter/utilis/routers/routes_name.dart';
import 'package:ghino_gas_flutter/utilis/utilis.dart';
import 'package:ghino_gas_flutter/views/modules/login/login_viewModel.dart';
import 'package:ghino_gas_flutter/views/widgets/button/round_button.dart';
import 'package:ghino_gas_flutter/views/widgets/button/round_button_icon.dart';
import 'package:ghino_gas_flutter/views/widgets/widgetCompomentLess.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final FocusNode _emailFN = FocusNode();
  final FocusNode _passwordFN = FocusNode();

  final _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroudApp,
        body: SingleChildScrollView(
          padding: WidgetLess.edgeInsetSplitScreen(context,
              left: 10, right: 10, top: 6.6),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Hi,Welcome back! 👋",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                Obx(
                  () => TextFormField(
                    controller: _controller.emailController,
                    focusNode: _emailFN,
                    onFieldSubmitted: (value) {
                      Utils.fieldFocusChange(context, _emailFN, _passwordFN);
                    },
                    decoration: InputDecoration(
                        hintText: "example@gmail.com",
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: TextStyleApp.fontSize),
                        hintStyle: TextStyle(fontSize: TextStyleApp.fontSize),
                        prefixIcon: const Icon(Icons.email_outlined),
                        errorText: _controller.errorEmail == ""
                            ? null
                            : _controller.errorEmail,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => TextFormField(
                    controller: _controller.passwordController,
                    obscureText: _controller.visibilityPassword,
                    focusNode: _passwordFN,
                    onFieldSubmitted: (value) async {
                      await _controller.signInWithEmailAndPassword();
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: "Nhập mật khẩu của bạn",
                      labelText: "Mật khẩu",
                      labelStyle: TextStyle(fontSize: TextStyleApp.fontSize),
                      hintStyle: TextStyle(fontSize: TextStyleApp.fontSize),
                      errorText: _controller.errorPassword == ""
                          ? null
                          : _controller.errorPassword,
                      prefixIcon: const Icon(Icons.lock_open_outlined),
                      suffixIcon: IconButton(
                          icon: _controller.visibilityPassword
                              ? const Icon(Icons.visibility_off_outlined)
                              : const Icon(Icons.visibility_outlined),
                          onPressed: () {
                            _controller.setVisibilityPassword();
                          }),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Quên mật khẩu ?",
                        style: TextStyle(
                            fontSize: TextStyleApp.fontSize - 2,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffE86969)),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                RoundButton(
                  onPressed: () async {
                    await _controller.signInWithEmailAndPassword();
                  },
                  title: "Đăng nhập",
                  loading: !true,
                  textStyle: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: TextStyleApp.fontSize),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Hoặc với",
                        style: TextStyle(fontSize: TextStyleApp.fontSize + 2),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                RoundButtonImage(
                    title: "Đăng nhập với Google",
                    onPressed: () {
                      _controller.signInGoogle();
                    },
                    isOutLine: true,
                    radius: 15,
                    textStyle: TextStyle(
                        fontSize: TextStyleApp.fontSize,
                        color: AppColors.mediumBlack),
                    pathImage: "assets/icons/Google Logo2.png"),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bạn chưa có tài khoản ?",
                      style: TextStyle(
                        fontSize: TextStyleApp.fontSize,
                        color: const Color(0xff0D0E0E),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.toNamed(RoutesName.signup);
                        },
                        child: Text(
                          "Đăng ký ngay",
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
      ),
    );
  }
}
