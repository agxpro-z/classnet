import 'package:classnet/app/utils/string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

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
    List<Assignment> list = [];

    for (var snapshot in snapshotList.docs) {
      final data = await snapshot.reference.get();
      final snapshotData = data.data() as Map<String, dynamic>;

      list.add(Assignment(
        title: snapshotData['title'] as String,
        description: snapshotData['description'] as String,
        creator: snapshotData['creator'] as String,
        points: snapshotData['points'] as int,
        createdOn: snapshotData['createdOn'] as DateTime,
      ));
    }

    return list;
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
