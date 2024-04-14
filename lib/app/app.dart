import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked_annotations.dart';

import 'ui/views/login/login_view.dart';
import 'ui/views/navigation/navigation_view.dart';
import 'ui/views/navigation/navigation_viewmodel.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: NavigationView)
  ],
  dependencies: [
    LazySingleton(classType: NavigationViewModel)
  ]
)
class AppSetup {}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const NavigationView();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
