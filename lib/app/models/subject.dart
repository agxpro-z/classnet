import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../utils/string.dart';
import 'assignment.dart';

@lazySingleton
class Subject {
  Subject({
    required this.title,
    required this.subCode,
    required this.assignmentCount,
    required this.collectionReference,
    this.department,
    this.course,
  });

  final String title;
  final String subCode;
  int assignmentCount;
  final CollectionReference collectionReference;
  String? department;
  String? course;

  Future<int> updateAssignmentCount() async {
    final snapshotList = await collectionReference.get();
    bool reduceCount = false;

    for (var snapshot in snapshotList.docs) {
      if (snapshot.id == 'details') {
        reduceCount = true;
        break;
      }
    }

    return assignmentCount = reduceCount ? snapshotList.docs.length - 1 : snapshotList.docs.length;
  }

  Future<List<Assignment>> getAssignments() async {
    final snapshotList = await collectionReference.get();
    List<Assignment> list = <Assignment>[];

    for (var snapshot in snapshotList.docs) {
      final data = await snapshot.reference.get();
      final snapshotData = data.data() as Map<String, dynamic>;

      if (snapshotData['title'] == null) {
        continue;
      }

      list.add(Assignment(
        title: snapshotData['title'] as String,
        description: snapshotData['description'] as String,
        creator: snapshotData['creator'] as String,
        points: snapshotData['points'] as int,
        createdOn: snapshotData['createdOn']?.toDate() ?? DateTime.now().subtract(const Duration(days: 7)),
        due: snapshotData['due']?.toDate() ?? DateTime.now().add(const Duration(days: 7)),
        documentReference: snapshot.reference,
        subject: title,
      ));
    }
    return list;
  }

  Future<void> addAssignment(Assignment assignment) async {
    await collectionReference.add({
      'title': assignment.title,
      'description': assignment.description,
      'points': assignment.points,
      'creator': assignment.creator,
      'createdOn': assignment.createdOn,
      'due': assignment.due,
      'subject': title,
    });
  }

  String abbreviate(String string) {
    String str = '';
    for (var item in string.split(' ')) {
      if (item.isTitleCase()) {
        str += item[0];
      }
    }
    return str;
  }

  String courseShort() {
    if (course == null) {
      return null.toString();
    }
    return abbreviate(course!);
  }

  String departmentShort() {
    if (department == null) {
      return null.toString();
    }
    return abbreviate(department!);
  }
}
