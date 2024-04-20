import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked_annotations.dart';

import 'ui/views/login/login_view.dart';
import 'ui/views/add_assignment/add_assignment_view.dart';
import 'ui/views/add_assignment/add_assignment_viewmodel.dart';
import 'ui/views/assignment/assignment_view.dart';
import 'ui/views/assignment/assignment_viewmodel.dart';
import 'ui/views/assignments/assignments_view.dart';
import 'ui/views/assignments/assignments_viewmodel.dart';
import 'ui/views/home/home_view.dart';
import 'ui/views/home/home_viewmodel.dart';
import 'ui/views/navigation/navigation_view.dart';
import 'ui/views/navigation/navigation_viewmodel.dart';
import 'ui/views/preferences/preferences_view.dart';
import 'ui/views/preferences/preferences_viewmodel.dart';
import 'ui/views/schedule/schedule_view.dart';
import 'ui/views/schedule/schedule_viewmodel.dart';
import 'ui/views/subjects/subjects_view.dart';
import 'ui/views/subjects/subjects_viewmodel.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: AddAssignmentView),
    MaterialRoute(page: AssignmentView),
    MaterialRoute(page: AssignmentsView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: NavigationView),
    MaterialRoute(page: PreferencesView),
    MaterialRoute(page: ScheduleView),
    MaterialRoute(page: SubjectsView),
  ],
  dependencies: [
    LazySingleton(classType: AddAssignmentViewModel),
    LazySingleton(classType: AssignmentViewModel),
    LazySingleton(classType: AssignmentsViewModel),
    LazySingleton(classType: HomeViewModel),
    LazySingleton(classType: NavigationViewModel),
    LazySingleton(classType: PreferencesViewModel),
    LazySingleton(classType: ScheduleViewModel),
    LazySingleton(classType: SubjectsViewModel),
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
