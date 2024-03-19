import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectsProvider {
  Future<Map<String, dynamic>?> _fetch(String sem) async {
    final data = await FirebaseFirestore.instance
        .collection('mca22')
        .doc(sem)
        .get();

    return data.data();
  }

  /*
   * Fetch raw subjects data and return map.
   *
   * @param
   *    sem - semester (Eg.: sem1, sem2)
   */
  Future<Map<String, dynamic>> getSubjects(String sem) async {
    final data = await _fetch(sem);
    return data ?? <String, dynamic>{};
  }

  /*
   * Return a map of all subjects of a particular semester.
   *
   * @param
   *    sem - semester (Eg.: sem1, sem2)
   */
  Future<List<Map<String, dynamic>>> getSubjectList(String sem) async {
    final data = await _fetch(sem);
    return data?.values.cast<Map<String, dynamic>>().toList() ?? [];
  }

  /*
   * Return map of subject with details.
   *
   * @param
   *    sem - semester (Eg.: sem1, sem2)
   *    subId - Id of the the subject.
   */
  Future<Map<String, dynamic>> getSubjectDetail(String subId, String sem) async {
    final data =  await getSubjects(sem);
    return data[subId];
  }

  /*
   * Provide no. of assignments in the given subject.
   *
   * @param
   *    sem - semester
   *    subCollectionId - subject['collection']
   */
  Future<int> getAssignmentCount(String sem, String subCollectionId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('mca22')
        .doc(sem)
        .collection(subCollectionId)
        .get();

    return snapshot.size;
  }
}
