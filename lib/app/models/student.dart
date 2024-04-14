import 'package:injectable/injectable.dart';

import 'app_user.dart';

@lazySingleton
class Student extends AppUser {
  Student({
    required super.firstname,
    required super.lastname,
    required super.user,
    required super.isStudent,
    required super.department,
    required this.rollNo,
    required this.branchName,
    required this.courseName,
  });

  final String rollNo;
  final String branchName;
  final String courseName;

  // TODO - Implement course model
}
