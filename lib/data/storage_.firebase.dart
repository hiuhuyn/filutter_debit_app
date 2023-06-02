import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageFirebase {
  static final _storageRef = FirebaseStorage.instance.ref();

  static Future<String> uploadSrcImg(String pathFile) async {
    String pathName =
        "images/${DateTime.now().toString()}_${pathFile.split("/").last}";
    await _storageRef.child(pathName).putFile(File(pathFile)).then((p0) => null,
        onError: (e) {
      pathName = "";
      print("Error upload_srcImg: $e");
    });
    return pathName;
  }

  static Future deleteImage(String path) async {
    final reference = _storageRef.child(path);
    await reference.delete();
  }

  static Future<String> getUrlFile(String path) async {
    final reference = _storageRef.child(path);
    String url = await reference.getDownloadURL();
    return url;
  }
}
