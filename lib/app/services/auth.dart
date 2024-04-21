import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../i18n/strings.g.dart';

class Auth {
  static String getUserEmail() {
    return FirebaseAuth.instance.currentUser?.email ?? t.auth.invalidEmail;
  }

  static String getUserName() {
    return FirebaseAuth.instance.currentUser?.displayName ?? t.auth.invalidUser;
  }

  static Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> signUp(
    BuildContext context,
    String name,
    String branch,
    String course,
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (password != confirmPassword) {
      return;
    }

    try {
      UserCredential newUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await newUser.user?.updateDisplayName(name);
    } on FirebaseAuthException {
      // print(e);
    }

    // Pop the register page after successful registration.
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
