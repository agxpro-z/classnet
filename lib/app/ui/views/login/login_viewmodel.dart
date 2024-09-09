import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../services/auth.dart';

@lazySingleton
class LoginViewModel extends BaseViewModel {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async {
    if (await Auth.signIn(emailController.text.trim(), passwordController.text)) {
      passwordController.text = "";
    }
  }
}
