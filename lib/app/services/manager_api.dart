import 'package:classnet/app/models/subject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/course.dart';
import '../models/semester.dart';
import '../models/tsemester.dart';
import 'app_user.dart';

@lazySingleton
class ManagerAPI {
  late Course _course;
  late Semester _currentSem;
  late TSemester _currentTSemester;

  Future<void> initialize() async {
    await initializeCourse();
  }

  Future<void> initializeCourse() async {
    final AppUserService appUserService = AppUserService();

    if (appUserService.isStudent()) {
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
  }
  Course getCourse() => _course;

  Future<void> initializeCurrentSem() async {
    await initialize();
    _currentSem = await _course.getSemesterFor('sem4');
  }
  Semester getCurrentSem() => _currentSem;

  Future<void> initializeCurrentTSem() async {
    final tData = await FirebaseFirestore.instance
        .collection('faculty')
        .doc(AppUserService().getEmail())
        .get();

    final List<String> ayList = tData.data()?['academicYear'].cast<String>();
    _currentTSemester = TSemester(title: ayList.last, collectionReference: tData.reference.collection(ayList.first));
  }
  TSemester getTSemester() => _currentTSemester;

  List<String> getSemList() => _course.semList;

  Future<List<String>> getAYList() async {
    final tData = await FirebaseFirestore.instance
        .collection('faculty')
        .doc(AppUserService().getEmail())
        .get();

    return tData.data()?['academicYear'].cast<String>();
  }

  Future<List<Subject>> getSubjectList(String id) async {
    if (AppUserService().isStudent()) {
      final tmpSem = await _course.getSemesterFor(id);
      return await tmpSem.getAllSubjects();
    } else {
      final tData = await FirebaseFirestore.instance
          .collection('faculty')
          .doc(AppUserService().getEmail())
          .get();

      return await TSemester(title: id, collectionReference: tData.reference.collection(id)).getSubjects();
    }
  }
}
