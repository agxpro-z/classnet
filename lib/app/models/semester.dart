// Copyright 2024 agxpro.dev
// Author: Ankit Gourav (agxpro)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'subject.dart';

@lazySingleton
class Semester {
  Semester({
    required this.title,
    required this.subList,
    this.documentReference,
  });

  final String title;
  final Map<String, String> subList;
  DocumentReference? documentReference;

  Future<Subject> getSubject(String subCode) async {
    final CollectionReference collectionReference = documentReference!.collection(subCode);
    final snapshotList = await collectionReference.get();
    bool reduceCount = false;

    for (var snapshot in snapshotList.docs) {
      if (snapshot.id == 'details') {
        reduceCount = true;
        break;
      }
    }
    int assignmentCount = reduceCount ? snapshotList.docs.length - 1 : snapshotList.docs.length;

    return Subject(
      title: subList[subCode].toString(),
      subCode: subCode,
      assignmentCount: assignmentCount,
      collectionReference: collectionReference,
    );
  }

  Future<List<Subject>> getAllSubjects() async {
    final List<Subject> subjectList = [];

    for (var subCode in subList.keys) {
      subjectList.add(await getSubject(subCode));
    }

    return subjectList;
  }
}
