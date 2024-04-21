import 'package:injectable/injectable.dart';

import 'app_user.dart';

@lazySingleton
class Teacher extends AppUser {
  Teacher({
    required super.firstname,
    required super.lastname,
    required super.user,
    required super.isStudent,
    required super.department,
  });
}
