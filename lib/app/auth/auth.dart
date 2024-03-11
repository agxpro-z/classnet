import 'package:firebase_auth/firebase_auth.dart';

import '../../res/values/strings.dart';

class Auth {
  static String getUserEmail() {
    return FirebaseAuth.instance.currentUser?.email ?? Strings.invalidEmail;
  }

  static String getUserName() {
    return FirebaseAuth.instance.currentUser?.displayName ?? Strings.invalidUser;
  }

  static Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}