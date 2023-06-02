import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghino_gas_flutter/utilis/utilis.dart';
import 'package:ghino_gas_flutter/views/modules/newDetor/newDebtor_viewModol.dart';
import 'package:ghino_gas_flutter/views/widgets/button/round_button.dart';

class NewDebtorScreen extends StatelessWidget {
  NewDebtorScreen({super.key});
  final _controller = Get.put(NewDebtorController());
  final _focusNodeName = FocusNode();
  final _focusNodePhone = FocusNode();
  final _focusNodeAddress = FocusNode();
  final _focusNodeNote = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm người nợ mới"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
                height: 100,
                width: 100,
                child: FittedBox(
                  child: Obx(() =>
                      _controller.imageProviderAndCheck(_controller.pathAvt)),
                ),
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      await _controller.pickImageFromCamera();
                    },
                    icon: const Icon(Icons.photo_camera)),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () async {
                      await _controller.pickImageFromGallery();
                    },
                    icon: const Icon(Icons.photo)),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => TextFormField(
                controller: _controller.ctrlName,
                keyboardType: TextInputType.name,
                maxLines: null,
                maxLength: 60,
                focusNode: _focusNodeName,
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(
                      context, _focusNodeName, _focusNodePhone);
                },
                decoration: InputDecoration(
                    hintText: "Nhập họ và tên",
                    labelText: "Họ và tên",
                    labelStyle: const TextStyle(fontSize: 18),
                    errorText: _controller.errotName,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.person_outline_outlined)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _controller.ctrlPhone,
              maxLength: 11,
              keyboardType: TextInputType.phone,
              focusNode: _focusNodePhone,
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(
                    context, _focusNodePhone, _focusNodeAddress);
              },
              decoration: const InputDecoration(
                  hintText: "Nhập số điện thoại",
                  labelText: "Số điện thoại",
                  labelStyle: TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  icon: Icon(Icons.phone)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _controller.ctrlAddress,
              maxLines: null,
              maxLength: 255,
              focusNode: _focusNodeAddress,
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(
                    context, _focusNodePhone, _focusNodeAddress);
              },
              decoration: const InputDecoration(
                  hintText: "Nhập địa chỉ",
                  labelText: "Địa chỉ",
                  labelStyle: TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  icon: Icon(Icons.map)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _controller.ctrlNote,
              maxLines: null,
              maxLength: 255,
              focusNode: _focusNodeNote,
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(
                    context, _focusNodeAddress, _focusNodeNote);
              },
              decoration: const InputDecoration(
                  hintText: "Nhập ghi chú",
                  labelText: "Ghi chú",
                  labelStyle: TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  icon: Icon(Icons.edit_note)),
            ),
            const SizedBox(
              height: 40,
            ),
            RoundButton(
                title: "Lưu",
                onPressed: () {
                  _controller.createDebtor();
                }),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
