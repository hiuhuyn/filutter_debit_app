import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghino_gas_flutter/models/debtorModel.dart';
import 'package:ghino_gas_flutter/res/text_style.dart';
import 'package:ghino_gas_flutter/views/modules/showItemDebit/showItemDebit_screen.dart';
import 'package:intl/intl.dart';

import '../../data/debtor_firebase.dart';
import '../../models/debitModel.dart';

class ItemDebit extends StatelessWidget {
  final Debit debit;
  Rx<Debtor> rxDebtor = Debtor().obs;
  var urlAvt = "".obs;

  ItemDebit({super.key, required this.debit}) {
    DebtorFirebase.searchById(debit.idDebtor).then((value) {
      if (value != null) {
        rxDebtor.value = value;
        rxDebtor.value.getUrlAvt.then((value) {
          urlAvt.value = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        debit.isFinish ? Colors.grey.shade300 : Colors.white;
    Color boxShadowColor = debit.isFinish ? Colors.black : Colors.grey;

    Widget avt = Obx(
      () => urlAvt.value.isNotEmpty
          ? CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(urlAvt.value),
            )
          : CircleAvatar(
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset("assets/icons/user.png"),
              )),
    );

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                  color: boxShadowColor,
                  offset: const Offset(2, 2),
                  blurRadius: 2,
                  spreadRadius: 2)
            ]),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                            )
                          ]),
                      child: FittedBox(
                        child: avt,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(
                      () => Text(
                        rxDebtor.value.name,
                        style: TextStyle(
                            fontSize: TextStyleApp.fontSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      Get.to(ShowItemDebit(
                        debit: debit,
                        debtor: rxDebtor.value,
                      ));
                    },
                    icon: const Icon(Icons.settings)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thời gian: ",
                  style: TextStyle(
                      fontSize: TextStyleApp.fontSize,
                      fontWeight: FontWeight.bold),
                ),
                Text(DateFormat('dd/MM/yyyy').format(debit.debtDay),
                    style: TextStyle(fontSize: TextStyleApp.fontSize)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  debit.isPay ? "Phải trả: " : "Phải thu: ",
                  style: TextStyle(
                      fontSize: TextStyleApp.fontSize,
                      fontWeight: FontWeight.bold),
                ),
                Text("${debit.money} đ",
                    style: TextStyle(
                        fontSize: TextStyleApp.fontSize,
                        color: debit.isPay ? Colors.green : Colors.red)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tình trạng: ",
                  style: TextStyle(
                      fontSize: TextStyleApp.fontSize,
                      fontWeight: FontWeight.bold),
                ),
                Text(debit.isFinish ? "Đã xử lý" : "Chưa xử lý",
                    style: TextStyle(
                        fontSize: TextStyleApp.fontSize,
                        color: debit.isFinish ? Colors.blue : Colors.red)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ghi chú: ",
                  style: TextStyle(
                      fontSize: TextStyleApp.fontSize,
                      fontWeight: FontWeight.bold),
                ),
                Text(debit.note,
                    style: TextStyle(fontSize: TextStyleApp.fontSize)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
