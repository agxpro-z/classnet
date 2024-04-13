import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ui/views/login/login_view.dart';
import 'ui/views/navigation/navigation_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
