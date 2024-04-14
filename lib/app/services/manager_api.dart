import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/course.dart';
import 'app_user.dart';

@lazySingleton
class ManagerAPI {
  late Course _course;

  Future<void> initialize() async {
    final AppUserService appUserService = AppUserService();
    final CollectionReference courseReference = FirebaseFirestore.instance
      .collection(appUserService.getEmail().substring(2, 6));

    Map<String, dynamic> courseDetails = await appUserService.getCourseDetails();

    List<String> semList = [];
    for (int i = 1; i <= (courseDetails['semesters'] as int); ++i) {
      semList.add("sem$i");
    }

    _course = Course(name: courseDetails['course'] as String,
      branch: courseDetails['branch'] as String,
      department: courseDetails['department'] as String,
      semList: semList,
      collectionReference: courseReference,
    );
  }

  Course getCourse() => _course;
}
