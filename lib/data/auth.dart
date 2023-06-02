import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utilis/routers/routes_name.dart';
import '../../utilis/utilis.dart';

class Auth {
  static User? get currentUser => FirebaseAuth.instance.currentUser;
  //Thuộc tính currentUser của phiên bản FirebaseAuth :
  //nếu bạn chắc chắn người dùng hiện đang đăng nhập,
  //bạn có thể truy cập User từ thuộc tính currentUser

  // đăng nhập
  static Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  // đămh ký tài khoản
  static Future<UserCredential> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String displayName}) async {
    var userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user?.updateDisplayName(displayName);

    return userCredential;
  }

  // đăng xuất khỏi bộ nhớ
  static Future signOut() async {
    final bool isGoogleSignedIn = currentUser!.providerData
        .any((element) => element.providerId == "google.com");
    if (isGoogleSignedIn) {
      await GoogleSignIn().signOut();
    } else {
      await FirebaseAuth.instance.signOut();
    }
  }

  // // google
  // static Future<OAuthCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   // return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
  static Future<User?> signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(authCredential);

    final User? user = userCredential.user;
    return user;
  }

  static Future<bool> isEmailRegistered(String email) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      // Nếu danh sách phương thức liên kết email không trống,
      // nghĩa là địa chỉ email này đã được đăng ký với tài khoản khác.
      if (methods.isNotEmpty) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      // Xử lý lỗi nếu có
      print("Error isEmailRegistered:\nCode: ${e.code}\nMessage: ${e.message}");
    }

    return false;
  }
}
