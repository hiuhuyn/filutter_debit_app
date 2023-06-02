import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ghino_gas_flutter/views/modules/home/home_viewModel.dart';

import '../../models/debitModel.dart';
import 'auth.dart';

class DebitFirebase {
  static final _db = FirebaseFirestore.instance;

  static Future<DocumentReference> createDebit(Debit debit) async {
    return await _db.collection("debit").add(debit.toJson());
  }

  static Future<List<Debit>> selectAll() async {
    var user = Auth.currentUser;
    List<Debit> list = [];
    if (user != null) {
      await _db
          .collection("debit")
          .where("emailRoot", isEqualTo: user.email)
          .orderBy("debtDay", descending: true)
          .get()
          .then((value) {
        for (var item in value.docs) {
          var debit = Debit.fromJson(id: item.id, map: item.data());
          list.add(debit);
        }
      });
    }
    return list;
  }

  static Future updateDebit(Debit debit) async {
    return await _db.collection("debit").doc(debit.id).update(debit.toJson());
  }

  static Future deleteDebit(String id) async {
    return await _db.collection("debit").doc(id).delete();
  }

  static Future<Debit?> searchById(String id) async {
    Debit? debit;
    await _db.collection("debit").doc(id).get().then((value) {
      final data = value.data() as Map<String, dynamic>;
      debit = Debit.fromJson(id: value.id, map: data);
    });
    return debit;
  }
}
