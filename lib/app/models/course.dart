import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'semester.dart';
import 'task.dart';

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

  Future<List<Task>> getClassTimeTable(String day) async {
    final tData = await collectionReference.doc('details').get();
    List<Task> taskList = <Task>[];
    final data = (tData.data() as Map<String, dynamic>)['classTimeTable'][day].cast<String, String>();

    for (var key in data.keys.cast<String>()) {
      final time = (key as String).split(':');
      taskList.add(Task(
        title: data[key] as String,
        time: TimeOfDay(hour: int.parse(time[0]), minute: int.parse(time[1])),
      ));
    }
    return taskList;
  }
}
