import 'package:get/get.dart';
import 'package:ghino_gas_flutter/data/debtor_firebase.dart';
import 'package:ghino_gas_flutter/views/modules/newDebit/newDebit_viewModel.dart';

import '../../../models/debtorModel.dart';

class ShowDebtorListController extends GetxController {
  RxList<Debtor> debtors = RxList();
  Future loadingData() async {
    try {
      var list2 = Get.put(NewDebitController()).listDebtor;
      if (list2.isNotEmpty) {
        debtors.value = list2;
      } else {
        debtors.value = await DebtorFirebase.selectAll();
      }
    } catch (e) {
      print("loadingData Debtor: $e");
    }
    update();
  }
}
