import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghino_gas_flutter/data/storage_.firebase.dart';
import 'package:ghino_gas_flutter/views/modules/newDebit/newDebit_viewModel.dart';
import 'package:ghino_gas_flutter/views/modules/showDebtorList/showDebtorList_viewModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/auth.dart';
import '../../../data/debtor_firebase.dart';
import '../../../models/debtorModel.dart';

class NewDebtorController extends GetxController {
  final _pathAvt = "".obs;
  final ctrlName = TextEditingController();
  final ctrlPhone = TextEditingController();
  final ctrlAddress = TextEditingController();
  final ctrlNote = TextEditingController();
  final _pickker = ImagePicker();

  final _errorName = "".obs;

  Future pickImageFromGallery() async {
    try {
      var status = await Permission.camera.status;
      if (status.isDenied) {
        // We didn't ask for permission yet or the permission has been denied before but not permanently.
        if (await Permission.camera.request().isGranted) {
          // Either the permission was already granted before or the user just granted it.
          print("Permisssion was granted");
          await _pickker.pickImage(source: ImageSource.gallery).then((value) {
            if (value != null) {
              _pathAvt.value = value.path;
              print(value.path);
            }
          });
        } else {
          print("is granted false");
        }
      } else if (status.isGranted) {
        print("Permission isGranted");
        await _pickker.pickImage(source: ImageSource.gallery).then((value) {
          if (value != null) {
            _pathAvt.value = value.path;
            print(value.path);
          }
        });
      }
    } on PlatformException catch (e) {
      print("PlatformException pickImageFromGallery: $e");
    } catch (e) {
      print("Exceptioin pickImageFromGallery catch: $e");
    }
  }

  Future pickImageFromCamera() async {
    try {
      var status = await Permission.camera.status;
      if (status.isDenied) {
        // We didn't ask for permission yet or the permission has been denied before but not permanently.
        if (await Permission.camera.request().isGranted) {
          // Either the permission was already granted before or the user just granted it.
          print("Permisssion was granted");
          await _pickker.pickImage(source: ImageSource.camera).then((value) {
            if (value != null) {
              _pathAvt.value = value.path;
              print(value.path);
            }
          });
        } else {
          print("is granted false");
        }
      } else if (status.isGranted) {
        print("Permission isGranted");
        await _pickker.pickImage(source: ImageSource.camera).then((value) {
          if (value != null) {
            _pathAvt.value = value.path;
            print(value.path);
          }
        });
      }
    } on PlatformException catch (e) {
      print("PlatformException pickImageFromGallery: $e");
    } catch (e) {
      print("Exceptioin pickImageFromGallery catch: $e");
    }
  }

  Widget imageProviderAndCheck(String path) {
    try {
      if (path.isNotEmpty) {
        if (path.startsWith('http') || path.startsWith('https')) {
          return CircleAvatar(
            backgroundImage: NetworkImage(path),
          );
        }
        return CircleAvatar(backgroundImage: FileImage(File(path)));
      }
    } catch (e) {
      print(e);
    }
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Image.asset(
          "assets/icons/user.png",
          width: 50,
          height: 50,
        ));
  }

  String get pathAvt {
    return _pathAvt.value;
  }

  String? get errotName {
    if (_errorName.value.isEmpty) {
      return null;
    }
    return _errorName.value;
  }

  Future createDebtor() async {
    try {
      if (ctrlName.value.text.isEmpty) {
        _errorName.value = "Họ và tên không được để trống";
      } else {
        _errorName.value = "";
        if (Auth.currentUser != null) {
          Debtor debtor = Debtor.create(
              emailRoot: Auth.currentUser!.email.toString(),
              name: ctrlName.value.text.trim(),
              phoneNumber: ctrlPhone.text.trim(),
              address: ctrlAddress.text.trim(),
              note: ctrlNote.text.trim());

          await DebtorFirebase.createDebit(debtor).then((value) {
            debtor.idDebtor = value.id;
            StorageFirebase.uploadSrcImg(pathAvt).then((value) {
              debtor.urlAvt = value;
              DebtorFirebase.updateDebtor(debtor.idDebtor, debtor);
            });
            var ctrlNewDebit = Get.put(NewDebitController());
            ctrlNewDebit.listDebtor.add(debtor);
            ctrlNewDebit.listSearchDebtor.value = ctrlNewDebit.listDebtor;
            ctrlNewDebit.ctrlSearch.clear();
            ctrlNewDebit.update();
            Get.put(ShowDebtorListController()).loadingData();
            Get.back();
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
