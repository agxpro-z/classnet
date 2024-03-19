import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentsProvider {
  Future<List<Map<String, dynamic>>> getAssignmentList(String course, String sem, String subCollection) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(course)
        .doc(sem)
        .collection(subCollection)
        .get();

    return snapshot.docs.map((document) {
      return document.data();
    }).toList();
  }
}