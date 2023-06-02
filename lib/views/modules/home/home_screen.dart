import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/auth.dart';
import '../../../res/colors.dart';
import '../../../res/text_style.dart';
import '../../../utilis/routers/routes_name.dart';
import '../../../utilis/utilis.dart';
import '../../widgets/item_debit.dart';
import '../search.dart';
import 'home_viewModel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    _homeController.getData();

    return Scaffold(
      backgroundColor: AppColors.backgroudApp,
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            showSearch(context: context, delegate: SearchPeople());
          },
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tìm kiếm",
                    style: TextStyle(color: Colors.grey.shade800, fontSize: 18),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.grey.shade800,
                  ),
                ],
              )),
        ),
      ),
      drawer: _drawerHome(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(2, 2))
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "8 đ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Phải trả",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "8 đ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.red.shade600,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Phải thu",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      _homeController.findDebitByDay(context);
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                    )),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed(RoutesName.newDebit);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Thêm",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)))
              ],
            ),
            const Divider(
              color: Colors.black,
            ),
            Obx(
              () => ListView.builder(
                itemCount: _homeController.listFindDebits.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ItemDebit(
                    debit: _homeController.listFindDebits[index],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Drawer _drawerHome() {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: FittedBox(
                child: Auth.currentUser?.photoURL != null
                    ? CircleAvatar(
                        backgroundImage:
                            NetworkImage("${Auth.currentUser?.photoURL}"),
                      )
                    : CircleAvatar(
                        child: Text("${Auth.currentUser?.displayName?[0]}"),
                      ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              Auth.currentUser?.displayName ?? "No user",
              style: TextStyle(
                  fontSize: TextStyleApp.fontSize + 2,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${Auth.currentUser?.email}",
              style: TextStyle(
                fontSize: TextStyleApp.fontSize,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Divider(
                color: AppColors.mediumBlack,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(RoutesName.showDebtorList);
              },
              icon: const Icon(
                Icons.people,
                color: Colors.white,
              ),
              label: const FittedBox(
                child: Text(
                  "Danh sách người nợ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: const Size(double.infinity, 50)),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
              onPressed: () async {
                try {
                  await Auth.signOut();
                  Get.offAllNamed(RoutesName.login);
                } catch (e) {
                  Utils.toastMessage("Lỗi signOut!\nMessage: $e");
                }
              },
              icon: const Icon(Icons.exit_to_app_outlined),
              label: const FittedBox(
                child: Text(
                  "Đăng xuất",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
