import 'package:get/get.dart';

import '../data/storage_.firebase.dart';

class Debtor {
  String emailRoot = "";
  String idDebtor = "";

  String name = "";
  String address = "";
  String phoneNumber = "";
  String note = "";
  String urlAvt = "";
  Debtor();

  Future<String> get getUrlAvt async {
    var url = "";
    try {
      if (urlAvt.isNotEmpty) {
        url = await StorageFirebase.getUrlFile(urlAvt);
      }
    } catch (e) {
      printError(info: e.toString());
    }
    return url;
  }

  Debtor.create(
      {required this.emailRoot,
      required this.name,
      this.address = "",
      this.phoneNumber = "",
      this.note = "",
      this.urlAvt = ""}) {}

  Debtor.fromJson({required this.idDebtor, required Map<String, dynamic> map}) {
    name = map["name"];
    address = map["address"];
    phoneNumber = map["phoneNumber"];
    note = map["note"];
    urlAvt = map["urlAvt"] ?? "";
    emailRoot = map["emailRoot"];
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{
      "emailRoot": emailRoot,
      "name": name,
      "address": address,
      "phoneNumber": phoneNumber,
      "note": note,
      "urlAvt": urlAvt
    };
    return data;
  }
}
