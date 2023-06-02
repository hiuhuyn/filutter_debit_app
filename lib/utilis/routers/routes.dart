import 'package:get/get.dart';
import 'package:ghino_gas_flutter/utilis/routers/routes_name.dart';
import 'package:ghino_gas_flutter/views/modules/intro.dart';
import 'package:ghino_gas_flutter/views/modules/home/home_screen.dart';
import 'package:ghino_gas_flutter/views/modules/login/login_screen.dart';
import 'package:ghino_gas_flutter/views/modules/signUp/signUp_screen.dart';

import '../../views/modules/newDebit/newDebit_screen.dart';
import '../../views/modules/newDetor/newDebtor_screen.dart';
import '../../views/modules/showDebtorList/showDebtorList_screen.dart';
import '../../views/modules/showItemDebit/showItemDebit_screen.dart';

class Routes {
  static List<GetPage> routes = [
    GetPage(
        name: RoutesName.login,
        page: () => LoginScreen(),
        transition: Transition.circularReveal),
    GetPage(name: RoutesName.signup, page: () => SignUpScreen()),
    GetPage(name: RoutesName.introView, page: () => const IntroView()),
    GetPage(
        name: RoutesName.home,
        page: () => HomeScreen(),
        transition: Transition.zoom),
    GetPage(
        name: RoutesName.newDebit,
        page: () => NewDebitScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: RoutesName.newDebtor,
        page: () => NewDebtorScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: RoutesName.showDebtorList,
        page: () => ShowDebtorListScreen(),
        transition: Transition.downToUp),
  ];
}
