import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentsProvider {
  /*
   * Provides no. of assignments in the given subject.
   *
   * @param
   *    sem - semester
   *    subCollectionId - subject['collection']
   */
  Future<int> getAssignmentCount(String collection, String sem, String subCollectionId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(collection)
        .doc(sem)
        .collection(subCollectionId)
        .get();

    return snapshot.size;
  }

  /*
   * Provides list of assignments of the given subject.
   *
   * @param
   *    course - Course collection
   *    sem - semester
   *    subCollectionId - subject['collection']
   */
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