import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../models/app_user.dart';
import '../models/student.dart';
import '../models/teacher.dart';

@lazySingleton
class AppUserService {
  User? getCurrentUser() => FirebaseAuth.instance.currentUser;
  String getEmail() => getCurrentUser()?.email ?? '';

  Future<Map<String, dynamic>> getUserDetails(String email) async {
    Map<String, dynamic> data = {};

    if (email.contains('student')) {
      await FirebaseFirestore.instance.collection(email.substring(2, 6)).doc('student').get().then((value) {
        if (value.data() != null && value.data()!.containsKey(email)) {
          data = value.data()?[email];
        }
      });
    } else {
      await FirebaseFirestore.instance.collection('faculty').doc('shadow').get().then((value) {
        if (value.data() != null) {
          data = value.data()!;
        }
      });
    }

    return data;
  }

  Future<Map<String, dynamic>> getCourseDetails(String email) async {
    Map<String, dynamic> data = {};
    await FirebaseFirestore.instance.collection(email.substring(2, 6)).doc('student').get().then((value) {
      if (value.data() != null) {
        data = value.data()!;
      }
    });

    return data;
  }

  Future<AppUser> getUser() async {
    final String email = getEmail();
    final bool isStudent = email.contains('student');

    Map<String, dynamic> userDetails = await getUserDetails(email);
    Map<String, dynamic> courseDetails = await getCourseDetails(email);

    if (isStudent) {
      return Student(
        firstname: userDetails['firstname'] as String,
        lastname: userDetails['lastname'] as String,
        isStudent: isStudent,
        user: getCurrentUser()!,
        rollNo: userDetails['rollno'] as String,
        branchName: courseDetails['branch'] as String,
        courseName: courseDetails['course'] as String,
        department: courseDetails['department'] as String,
      );
    } else {
      return Teacher(
        firstname: userDetails['firstname'] as String,
        lastname: userDetails['lastname'] as String,
        user: getCurrentUser()!,
        isStudent: isStudent,
        department: userDetails['department'] as String,
      );
    }
  }
}
