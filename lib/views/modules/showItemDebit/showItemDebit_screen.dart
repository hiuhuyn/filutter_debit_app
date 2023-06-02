import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghino_gas_flutter/models/debitModel.dart';
import 'package:ghino_gas_flutter/models/debtorModel.dart';
import 'package:ghino_gas_flutter/views/modules/showItemDebit/showItemDebit_viewModel.dart';
import 'package:ghino_gas_flutter/views/widgets/button/round_button.dart';
import 'package:intl/intl.dart';

import '../../../res/text_style.dart';
import '../../../utilis/utilis.dart';

class ShowItemDebit extends StatelessWidget {
  Debit debit;
  Debtor debtor;
  ShowItemDebit({
    super.key,
    required this.debit,
    required this.debtor,
  });
  final _controller = Get.put(ShowDebitController());

  Widget _avtDebtor(String url) {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 1,
        )
      ]),
      child: FittedBox(
        child: url.isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage(url),
              )
            : CircleAvatar(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset("assets/icons/user.png"),
                )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _controller.loadingData(debit);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin nợ"),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _avtDebtor(debtor.urlAvt),
              Text(
                debtor.name,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thời gian nợ: ",
                    style: TextStyle(
                        fontSize: TextStyleApp.fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(DateFormat('dd/MM/yyyy').format(debit.debtDay),
                      style: TextStyle(fontSize: TextStyleApp.fontSize)),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: Colors.black,
                ),
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: Colors.black,
                ),
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
                  Expanded(
                    child: Obx(() => Text(
                        _controller.isFinish.value ? "Đã xử lý" : "Chưa xử lý",
                        style: TextStyle(
                            fontSize: TextStyleApp.fontSize,
                            color: _controller.isFinish.value
                                ? Colors.blue
                                : Colors.red))),
                  ),
                  IconButton(
                      onPressed: () {
                        _controller.onChangeFinish();
                      },
                      icon: const Icon(Icons.restart_alt))
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Người xác nhận: ",
                    style: TextStyle(
                        fontSize: TextStyleApp.fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(
                          debit.verifierDebtor.isEmpty
                              ? "Không có người xác nhận"
                              : debit.verifierDebtor,
                          style: TextStyle(
                              fontSize: TextStyleApp.fontSize,
                              color: debit.verifierDebtor.isNotEmpty
                                  ? Colors.blue
                                  : Colors.red))),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Người xác nhận trả nợ: ",
                    style: TextStyle(
                        fontSize: TextStyleApp.fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Obx(() {
                      return Text(
                          _controller.verifierPay.value.isEmpty
                              ? "Không có người xác nhận"
                              : _controller.verifierPay.value,
                          style: TextStyle(
                              fontSize: TextStyleApp.fontSize,
                              color: _controller.verifierPay.value.isNotEmpty
                                  ? Colors.blue
                                  : Colors.red));
                    }),
                  ),
                  IconButton(
                      onPressed: () {
                        _controller.onChangeVerifierPay(context);
                      },
                      icon: const Icon(Icons.edit))
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thời gian trả nợ: ",
                    style: TextStyle(
                        fontSize: TextStyleApp.fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Obx(() {
                      return Text(
                          DateFormat('dd/MM/yyyy')
                              .format(_controller.payDay.value),
                          style: TextStyle(fontSize: TextStyleApp.fontSize));
                    }),
                  ),
                  IconButton(
                      onPressed: () {
                        _controller.onChangePayDay(context);
                      },
                      icon: const Icon(Icons.calendar_month))
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: Colors.black,
                ),
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
                  Expanded(
                    child: Obx(() {
                      return Text(_controller.note.value,
                          style: TextStyle(fontSize: TextStyleApp.fontSize));
                    }),
                  ),
                  IconButton(
                      onPressed: () {
                        _controller.onChangeNote(context);
                      },
                      icon: const Icon(Icons.edit))
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: RoundButton(
                      backgroundColor: Colors.red,
                      title: "Xóa thông tin",
                      onPressed: () {
                        _controller.deleteDebit(context);
                      })),
              Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 40),
                  child: RoundButton(
                      backgroundColor: Colors.blue,
                      title: "Lưu thông tin",
                      onPressed: () {
                        _controller.saveData(context);
                      })),
            ],
          )),
    );
  }
}
