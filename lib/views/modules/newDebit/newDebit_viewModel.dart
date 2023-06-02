import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ghino_gas_flutter/models/debitModel.dart';
import 'package:ghino_gas_flutter/views/modules/home/home_viewModel.dart';
import '../../../data/auth.dart';
import '../../../data/debit_firebase.dart';
import '../../../data/debtor_firebase.dart';
import '../../../models/debtorModel.dart';
import '../../../utilis/utilis.dart';

class NewDebitController extends GetxController {
  final RxBool _isPay = false.obs;
  final Rx<Debtor> _rxDebtor = Debtor().obs;
  Rx<DateTime> debtDay = DateTime.now().obs;
  TextEditingController ctrlMoney = TextEditingController();
  TextEditingController ctrlVerifierDebtor = TextEditingController();
  TextEditingController ctrlNote = TextEditingController();
  TextEditingController ctrlSearch = TextEditingController();
  final RxString _errorMoney = "".obs;
  final RxString _errorVerifierDebtor = "".obs;
  final RxList<Debtor> listDebtor = RxList();
  final RxList<Debtor> listSearchDebtor = RxList();

  final RxDouble _heightLv = 60.0.obs;
  double get heightLv {
    if (listSearchDebtor.length > 4) {
      return _heightLv.value = 70 * 4;
    } else {
      return _heightLv.value = 10.0 + 70 * listSearchDebtor.length;
    }
  }

  String? get errorMoney {
    if (_errorMoney.value.isEmpty) {
      return null;
    }
    return _errorMoney.value;
  }

  String? get errorVerifierDebtor {
    if (_errorVerifierDebtor.value.isEmpty) {
      return null;
    }
    return _errorVerifierDebtor.value;
  }

  bool get isPay => _isPay.value;
  changeIsPay() {
    _isPay.value = !_isPay.value;
  }

  String get nameDebtor {
    return _rxDebtor.value.name;
  }

  setDebtor(Debtor debtor) {
    _rxDebtor.value = debtor;
  }

  onChangeSearch(String value) {
    if (value.isEmpty) {
      listSearchDebtor.value = listDebtor;
    } else {
      listSearchDebtor.value = [];
      for (var item in listDebtor) {
        if (item.name.toLowerCase().contains(value)) {
          listSearchDebtor.add(item);
        }
      }
    }
    update();
  }

  loadingDebtor() async {
    await DebtorFirebase.selectAll().then((value) {
      listDebtor.value = value;
      listSearchDebtor.value = value;
    });
  }

  bool isCheckEmpty(BuildContext context) {
    if (ctrlMoney.text.isEmpty) {
      _errorMoney.value = "Bạn chưa nhập số tiền nợ!";
      return true;
    }
    if (int.tryParse(ctrlMoney.text) == null) {
      _errorMoney.value = "Số tiền chỉ được chứa số!";
      return true;
    }
    _errorMoney.value = "";
    if (ctrlVerifierDebtor.text.isEmpty) {
      _errorVerifierDebtor.value = "Bạn chưa nhập người xác nhập tên!";
      return true;
    }
    _errorVerifierDebtor.value = "";

    if (Auth.currentUser == null) {
      Utils.alertdialog(
          context: context,
          title: "Bạn chưa đăng nhập",
          content: "Bạn có muốn đăng nhập ngay không?",
          onClickCancel: () {},
          onClickOk: () {});
      return true;
    }
    if (_rxDebtor.value.name.isEmpty) {
      Utils.alertdialog(
          context: context,
          title: "Lỗi",
          content: "Bạn chưa chọn người nợ, hãy chọn người nợ trước khi lưu!",
          onClickCancel: () {},
          onClickOk: () {});
      return true;
    }

    return false;
  }

  Future creatNewDebit(BuildContext context) async {
    try {
      if (!isCheckEmpty(context)) {
        Debit debit = Debit.create(
            emailRoot: Auth.currentUser!.email.toString(),
            money: int.tryParse(ctrlMoney.text.trim()) ?? 0,
            isPay: _isPay.value,
            idDebtor: _rxDebtor.value.idDebtor.trim(),
            verifierDebtor: ctrlVerifierDebtor.text.trim(),
            note: ctrlNote.text.trim(),
            debtDay: debtDay.value);

        Utils.alertdialog(
            context: context,
            title: "Thông báo",
            content: "Bạn chắc muốn thêm 1 bản ghi nợ mới không?",
            onClickCancel: () {},
            onClickOk: () async {
              await DebitFirebase.createDebit(debit).then((value) {
                debit.id = value.id;
                Get.put(HomeController()).addItemDebit(debit);
                Utils.toastMessage("Bạn đã thêm 1 nợ mới thành công!");
                Get.back();
              });
            });
      }
      update();
    } catch (e) {
      Utils.flushBarErrorMessage("Error creatNewDebit: $e", context);
    }
  }
}
