import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/debtorModel.dart';
import '../../res/text_style.dart';

class ItemDebtor extends StatelessWidget {
  Debtor debtor;
  var urlAvt = "".obs;

  ItemDebtor({super.key, required this.debtor}) {
    debtor.getUrlAvt.then((value) {
      urlAvt.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.blueGrey, offset: Offset(2, 2), blurRadius: 2)
        ],
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                height: 50,
                width: 50,
                decoration:
                    const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                  )
                ]),
                child: Obx(() {
                  return urlAvt.value.isNotEmpty
                      ? CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(urlAvt.value),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset("assets/icons/user.png"),
                          ));
                }),
              ),
              Text(
                debtor.name,
                style: TextStyle(
                    fontSize: TextStyleApp.fontSize,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Số điện thoại: ",
                style: TextStyle(
                    fontSize: TextStyleApp.fontSize,
                    fontWeight: FontWeight.bold),
              ),
              Text(debtor.phoneNumber,
                  style: TextStyle(
                      fontSize: TextStyleApp.fontSize, color: Colors.black)),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Địa chỉ: ",
                style: TextStyle(
                    fontSize: TextStyleApp.fontSize,
                    fontWeight: FontWeight.bold),
              ),
              Text(debtor.address,
                  style: TextStyle(
                      fontSize: TextStyleApp.fontSize, color: Colors.black)),
            ],
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
              Text(debtor.note,
                  style: TextStyle(
                      fontSize: TextStyleApp.fontSize, color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}
