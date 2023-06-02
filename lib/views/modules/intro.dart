import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghino_gas_flutter/utilis/routers/routes_name.dart';

import '../../data/auth.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    String route = _initialRoute();
    Timer(const Duration(seconds: 5), () {
      Get.offAllNamed(route);
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  String _initialRoute() {
    String routerName = RoutesName.login;
    if (Auth.currentUser != null) {
      routerName = RoutesName.home;
      print("home");
    } else {
      print("login");
      routerName = RoutesName.login;
    }
    print("routerName = $routerName");
    return routerName;
  }
}
