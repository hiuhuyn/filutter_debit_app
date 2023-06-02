import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghino_gas_flutter/utilis/routers/routes_name.dart';
import 'package:ghino_gas_flutter/utilis/utilis.dart';
import 'package:ghino_gas_flutter/views/modules/newDebit/newDebit_viewModel.dart';
import 'package:intl/intl.dart';

import '../../../models/debtorModel.dart';
import '../../../res/text_style.dart';
import '../../widgets/button/round_button.dart';

class NewDebitScreen extends StatelessWidget {
  NewDebitScreen({super.key});
  final _controller = Get.put(NewDebitController());
  final focusNodeMoney = FocusNode();
  final focusNodeVerifier = FocusNode();
  final focusNodeNote = FocusNode();

  @override
  Widget build(BuildContext context) {
    _controller.loadingDebtor();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm nợ mới"),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Loại nợ: ",
                  style: TextStyle(
                      fontSize: TextStyleApp.fontSize,
                      fontWeight: FontWeight.bold),
                ),
                Obx(
                  () => Text(
                    _controller.isPay ? "Phải trả" : "Phải thu",
                    style: TextStyle(
                        fontSize: TextStyleApp.fontSize + 5,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: _controller.isPay ? Colors.green : Colors.red),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _controller.changeIsPay();
                  },
                  child: Text(
                    "Đổi",
                    style: TextStyle(
                      fontSize: TextStyleApp.fontSize,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Người nợ:  ",
                  style: TextStyle(
                      fontSize: TextStyleApp.fontSize,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Obx(
                    () => Text(
                      _controller.nameDebtor.isEmpty
                          ? "Chưa có người nợ!"
                          : _controller.nameDebtor,
                      maxLines: null,
                      style: TextStyle(
                          fontSize: TextStyleApp.fontSize + 3,
                          fontWeight: FontWeight.bold,
                          color: _controller.nameDebtor.isEmpty
                              ? Colors.red
                              : Colors.blue),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.contacts),
                  onPressed: () {
                    showFormAddDebtor(context);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => TextFormField(
                controller: _controller.ctrlMoney,
                keyboardType: TextInputType.number,
                focusNode: focusNodeMoney,
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(
                      context, focusNodeMoney, focusNodeVerifier);
                },
                decoration: InputDecoration(
                    hintText: "Nhập số tiền",
                    labelText: "Số tiền",
                    errorText: _controller.errorMoney,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.attach_money)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => TextFormField(
                controller: _controller.ctrlVerifierDebtor,
                focusNode: focusNodeVerifier,
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(
                      context, focusNodeVerifier, focusNodeNote);
                },
                decoration: InputDecoration(
                    hintText: "Nhập người xác nhận nợ",
                    labelText: "Người xác nhận nợ",
                    errorText: _controller.errorVerifierDebtor,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.people)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _controller.ctrlNote,
              focusNode: focusNodeNote,
              maxLines: null,
              decoration: const InputDecoration(
                  hintText: "Ghi chú thêm",
                  labelText: "Ghi chú",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  icon: Icon(Icons.edit_note)),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Thời gian:",
                  style: TextStyle(
                      fontSize: TextStyleApp.fontSize,
                      fontWeight: FontWeight.bold),
                ),
                Obx(
                  () => Text(
                    DateFormat('dd/MM/yyyy').format(_controller.debtDay.value),
                    style: TextStyle(
                      fontSize: TextStyleApp.fontSize,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_month_outlined),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2030))
                        .then((value) {
                      if (value != null) {
                        _controller.debtDay.value = value;
                        Utils.toastMessage(value.toString());
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            RoundButton(
              onPressed: () async {
                await _controller.creatNewDebit(context);
              },
              title: "Lưu",
              backgroundColor: Colors.blue,
              radius: 18,
            )
          ],
        ),
      ),
    );
  }

  void showFormAddDebtor(BuildContext context) {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Obx(() {
              return SingleChildScrollView(
                child: Container(
                  height: _controller.heightLv + 300,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(4, 4),
                            blurRadius: 3)
                      ]),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Vui lòng chọn người nợ",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: _controller.ctrlSearch,
                        onChanged: (value) {
                          _controller.onChangeSearch(value);
                        },
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            hintText: "Tìm kiếm",
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _controller.ctrlSearch.clear();
                                  _controller.listSearchDebtor.value =
                                      _controller.listDebtor;
                                },
                                icon: const Icon(Icons.clear))),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: _controller.heightLv,
                        constraints: const BoxConstraints(minHeight: 70),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(2, 2),
                                  blurRadius: 3)
                            ]),
                        child: ListView.builder(
                          itemCount: _controller.listSearchDebtor.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                _controller.setDebtor(
                                    _controller.listSearchDebtor[index]);
                                Navigator.pop(context);
                              },
                              child: ListTile(
                                title: Text(
                                    _controller.listSearchDebtor[index].name),
                                subtitle: Text(
                                    "SDT: ${_controller.listSearchDebtor[index].phoneNumber}"),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Get.toNamed(RoutesName.newDebtor);
                              },
                              child: const Text("Thêm người mới")),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Hủy bỏ")),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
