import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghino_gas_flutter/views/modules/showDebtorList/showDebtorList_viewModel.dart';

import '../../../utilis/routers/routes_name.dart';
import '../../widgets/item_debtor.dart';

class ShowDebtorListScreen extends StatelessWidget {
  ShowDebtorListScreen({super.key});

  final _controllerDebtor = Get.put(ShowDebtorListController());

  @override
  Widget build(BuildContext context) {
    _controllerDebtor.loadingData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách người nợ"),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(RoutesName.newDebtor);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(() {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _controllerDebtor.debtors.length,
                itemBuilder: (context, index) {
                  return ItemDebtor(
                    debtor: _controllerDebtor.debtors[index],
                  );
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
