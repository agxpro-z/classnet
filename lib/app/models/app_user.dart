import 'package:firebase_auth/firebase_auth.dart';

import '../../res/strings.dart';

class AppUser {
  AppUser({
    required this.firstname,
    required this.lastname,
    required this.user,
    required this.isStudent,
    required this.department,
  });

  String firstname;
  String lastname;
  final User user;
  final bool isStudent;
  final String department;

  String get name => "$firstname $lastname";
  String get displayName => user.displayName ?? Strings.guestUser;
  String get email => user.email ?? '';

  void reload() async => user.reload();

  void updateName(String firstname, String lastname) async {
    this.firstname = firstname;
    this.lastname = lastname;
    await user.updateDisplayName(name);
  }

  void photoUrl() => user.photoURL ?? '';
}
