import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'semester.dart';

@lazySingleton
class Course {
  const Course({
    required this.name,
    required this.branch,
    required this.department,
    required this.semList,
    required this.collectionReference,
  });

  final String name;
  final String branch;
  final String department;
  final List<String> semList;
  final CollectionReference collectionReference;

  Future<List<String>> getStudentsList() async {
    final list = await collectionReference.doc('students').get();
    return (list.data() as Map<String, Map<String, String>>).values.map((student) => student['rollno']!).toList();
  }

  Future<Semester> getSemesterFor(String sem) async {
    final list = await collectionReference.get();
    for (var snapshot in list.docs) {
      if (sem == snapshot.id) {
        final String title = "Semester ${sem.substring(sem.length - 1)}";
        final subList = await collectionReference.doc(sem).get();

        return Semester(
          title: title,
          subList: (subList.data() as Map<String, dynamic>).cast<String, String>(),
          documentReference: snapshot.reference,
        );
      }
    }

    return Semester(title: 'Invalid Semester', subList: {});
  }
}
