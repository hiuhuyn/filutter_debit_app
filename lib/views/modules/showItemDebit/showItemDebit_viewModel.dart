import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghino_gas_flutter/data/debit_firebase.dart';
import 'package:ghino_gas_flutter/models/debitModel.dart';
import 'package:ghino_gas_flutter/views/modules/home/home_viewModel.dart';

import '../../../models/debtorModel.dart';
import '../../../utilis/utilis.dart';

class ShowDebitController extends GetxController {
  var _debit = Debit();
  var isFinish = false.obs;
  var payDay = DateTime.now().obs;
  var verifierPay = "".obs; // người xác minh trả nợ
  var note = "".obs;

  loadingData(Debit value) {
    _debit = value;
    isFinish.value = value.isFinish;
    payDay.value = value.payDay;
    verifierPay.value = value.verifierPay;
    note.value = value.note;
  }

  onChangeFinish() {
    isFinish.value = !isFinish.value;
    _debit.isFinish = isFinish.value;
  }

  onChangePayDay(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime(2030))
        .then((value) {
      if (value != null) {
        payDay.value = value;
        _debit.payDay = value;
        Utils.toastMessage(payDay.value.toString());
      }
    });
  }

  onChangeVerifierPay(BuildContext context) {
    var ctrlText = TextEditingController();
    ctrlText.text = verifierPay.value;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sửa tên người xác nhận trả nợ!"),
        content: TextFormField(
          controller: ctrlText,
          decoration: const InputDecoration(
              hintText: "Nhập tên người xác nhận",
              labelText: "Tên người xác nhận",
              labelStyle: TextStyle(fontSize: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              )),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, "Cancel");
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                verifierPay.value = ctrlText.text;
                _debit.verifierPay = ctrlText.text;
                Navigator.pop(context, "OK");
              },
              child: const Text("OK"))
        ],
      ),
    );
  }

  onChangeNote(BuildContext context) {
    var ctrlText = TextEditingController();
    ctrlText.text = note.value;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cập nhật ghi chú!"),
        content: TextFormField(
          controller: ctrlText,
          decoration: const InputDecoration(
              hintText: "Nhập ghi chú",
              labelText: "Ghi chú",
              labelStyle: TextStyle(fontSize: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              )),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, "Cancel");
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                note.value = ctrlText.text;
                _debit.note = ctrlText.text;
                Navigator.pop(context, "OK");
              },
              child: const Text("OK"))
        ],
      ),
    );
  }

  deleteDebit(BuildContext context) async {
    try {
      Utils.alertdialog(
          context: context,
          title: "Thông báo xóa",
          content: "Bạn có muốn xóa thông tin này không ?",
          onClickCancel: () {},
          onClickOk: () async {
            await DebitFirebase.deleteDebit(_debit.id);
            Get.put(HomeController()).removeItemDebit(_debit);

            Get.back();
          });
    } catch (e) {
      print("deleteDebit: $e");
    }
  }

  saveData(BuildContext context) async {
    try {
      Utils.alertdialog(
          context: context,
          title: "Thông báo cập nhật",
          content: "Xác nhận cập nhật ?",
          onClickCancel: () {},
          onClickOk: () async {
            await DebitFirebase.updateDebit(_debit);
            Get.put(HomeController()).updateItemDebit(_debit);
            Get.back();
          });
    } catch (e) {
      print("saveData: $e");
    }
  }
}
