// Copyright 2024 agxpro.dev
// Author: Ankit Gourav (agxpro)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'subject.dart';

@lazySingleton
class TSemester {
  const TSemester({
    required this.title,
    required this.collectionReference,
  });

  final String title;
  final CollectionReference collectionReference;

  Future<List<Subject>> getSubjects() async {
    final snapshot = await collectionReference.get();
    List<Subject> subjectList = <Subject>[];

    for (var doc in snapshot.docs) {
      final docSnapshot = await doc.reference.get();
      final data = (docSnapshot.data() as Map<String, dynamic>).cast<String, String>();

      var collectionRef = await FirebaseFirestore.instance.collection(data['course']!).doc('details').get();

      final String department = collectionRef.data()?['department']!;
      final String course = collectionRef.data()?['course']!;

      collectionRef = await FirebaseFirestore.instance.collection(data['course']!).doc(data['sem']!).get();
      final String title = collectionRef.data()?[data['subId']];

      final documentRef = collectionRef.reference.collection(data['subId']!);

      subjectList.add(Subject(
        title: title,
        subCode: data['subId']!,
        assignmentCount: 0,
        collectionReference: documentRef,
        department: department,
        course: course,
      ));

      await subjectList.last.updateAssignmentCount();
    }

    return subjectList;
  }
}
