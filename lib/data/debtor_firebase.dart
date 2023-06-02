import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghino_gas_flutter/models/debtorModel.dart';

import 'auth.dart';

class DebtorFirebase {
  static final _db = FirebaseFirestore.instance;
  static Future<DocumentReference> createDebit(Debtor debtor) async {
    return await _db.collection("debtors").add(debtor.toJson());
  }

  static Future<List<Debtor>> selectAll() async {
    var user = Auth.currentUser;
    List<Debtor> list = [];
    if (user != null) {
      await _db
          .collection("debtors")
          .where("emailRoot", isEqualTo: user.email)
          .get()
          .then((value) {
        for (var item in value.docs) {
          var debit = Debtor.fromJson(idDebtor: item.id, map: item.data());
          list.add(debit);
        }
      });
    }
    return list;
  }

  static Future updateDebtor(String id, Debtor debtor) async {
    return await _db.collection("debtors").doc(id).update(debtor.toJson());
  }

  static Future deleteDebtor(String id) async {
    return await _db.collection("debtors").doc(id).delete();
  }

  static Future<Debtor?> searchById(String id) async {
    Debtor? debtor;
    await _db.collection("debtors").doc(id).get().then((value) {
      if (value.data() != null) {
        debtor = Debtor.fromJson(
            idDebtor: value.id, map: value.data() as Map<String, dynamic>);
      }
    });

    return debtor;
  }

  static Future<List<Debtor>> searchByName(String name) async {
    List<Debtor> debtors = [];
    await _db
        .collection("debtor")
        .where("name", isEqualTo: name)
        .get()
        .then((value) {
      for (var data in value.docs) {
        final debtor = Debtor.fromJson(idDebtor: data.id, map: data.data());
        debtors.add(debtor);
      }
    });
    return debtors;
  }
}
