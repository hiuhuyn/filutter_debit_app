import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghino_gas_flutter/data/debit_firebase.dart';
import 'package:ghino_gas_flutter/models/debitModel.dart';
import 'package:ghino_gas_flutter/utilis/utilis.dart';

class HomeController extends GetxController {
  RxList<Debit> listAllDebits = RxList();
  RxList<Debit> listFindDebits = RxList();
  Future getData() async {
    try {
      await DebitFirebase.selectAll().then((value) {
        listAllDebits.value = value;
        listFindDebits.value = value;
      });
    } on FirebaseException catch (e) {
      print("Error getData: \nCode: ${e.code},\nMessage: ${e.message}");
      Utils.toastMessage("Error: ${e.message}");
    } catch (e) {
      print("Error getData Catch: $e");
    }
  }

  addItemDebit(Debit debit) {
    listAllDebits.insert(0, debit);
    listFindDebits.value = listAllDebits;
  }

  removeItemDebit(Debit debit) {
    for (var i = 0; i < listAllDebits.length; i++) {
      if (listAllDebits[i].id == debit.id) {
        listAllDebits.removeAt(i);
      }
    }
    for (var i = 0; i < listFindDebits.length; i++) {
      if (listFindDebits[i].id == debit.id) {
        listFindDebits.removeAt(i);
      }
    }
    update();
  }

  updateItemDebit(Debit debit) {
    for (var i = 0; i < listAllDebits.length; i++) {
      if (listAllDebits[i].id == debit.id) {
        listAllDebits[i] = debit;
      }
    }
    for (var i = 0; i < listFindDebits.length; i++) {
      if (listFindDebits[i].id == debit.id) {
        listFindDebits[i] = debit;
      }
    }
    update();
  }

  findDebitByDay(BuildContext context) {
    try {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2030))
          .then((value) {
        if (value != null) {
          List<Debit> listDebits = [];
          for (var index in listAllDebits) {
            var date = index.debtDay;
            if (date.year == value.year &&
                date.month == value.month &&
                date.day == value.day) {
              listDebits.add(index);
            }
          }
          print("find Update");
          listFindDebits.value = listDebits;
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
