import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static flushBarErrorMessage(String msg, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
            forwardAnimationCurve: Curves.decelerate,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            message: msg,
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            messageColor: Colors.blue,
            title: "SAD",
            reverseAnimationCurve: Curves.bounceInOut,
            positionOffset: 20,
            icon: const Icon(
              Icons.error,
              size: 30,
              color: Colors.white,
            ))
          ..show(context));
  }

  static snackbar(String msg, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(msg)));
  }

  static alertdialog(
      {required BuildContext context,
      required String title,
      required String content,
      required VoidCallback onClickCancel,
      required VoidCallback onClickOk}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, "Cancel"),
              child: const Text("Cancel")),
          TextButton(
              onPressed: () => Navigator.pop(context, "OK"),
              child: const Text("OK"))
        ],
      ),
    ).then((value) {
      if (value != null) {
        if (value.toString() == "Cancel") {
          onClickCancel();
        }
        if (value.toString() == "OK") {
          onClickOk();
        }
      }
    });
  }
}
