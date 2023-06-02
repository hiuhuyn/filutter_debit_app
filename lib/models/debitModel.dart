import 'package:cloud_firestore/cloud_firestore.dart';

class Debit {
  String id = "";
  String emailRoot = "";

  int money = 0;

  bool isFinish = false; // kiểm tra hoành thành ?
  bool isPay = false; // false: phải thu, true: phải trả

  String idDebtor = ""; // người nợ
  String verifierDebtor = ""; // người xác minh nợ
  DateTime debtDay = DateTime.now();

  DateTime payDay = DateTime.now();
  String verifierPay = ""; // người xác minh trả nợ
  String note = "";

  Debit();
  Debit.create(
      {required this.emailRoot,
      required this.money,
      required this.isPay,
      required this.idDebtor,
      required this.verifierDebtor,
      required this.debtDay,
      this.note = ""});

  Debit.fromJson({this.id = "", required Map<String, dynamic> map}) {
    idDebtor = map["idDebtor"];
    emailRoot = map["emailRoot"];
    money = map["money"] ?? 0;
    verifierDebtor = map["verifierDebtor"];
    debtDay = map["debtDay"].toDate() as DateTime;
    isPay = map["isPay"] ?? false;
    isFinish = map["isFinish"] ?? false;
    payDay = map["payDay"].toDate() as DateTime;
    verifierPay = map["verifierPay"];
    note = map["note"];
  }

  Map<String, dynamic> toJson() {
    return {
      "idDebtor": idDebtor,
      "emailRoot": emailRoot,
      "money": money,
      "verifierDebtor": verifierDebtor,
      "debtDay": debtDay,
      "isPay": isPay,
      "isFinish": isFinish,
      "payDay": payDay,
      "verifierPay": verifierPay,
      "note": note,
    };
  }
}
