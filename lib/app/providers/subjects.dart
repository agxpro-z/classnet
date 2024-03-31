import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectsProvider {
  Future<Map<String, dynamic>?> _fetch(String collection, String sem) async {
    final data = await FirebaseFirestore.instance
        .collection(collection)
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
  Future<Map<String, dynamic>> getSubjects(String collection, String sem) async {
    final data = await _fetch(collection, sem);
    return data ?? <String, dynamic>{};
  }

  /*
   * Return a map of all subjects of a particular semester.
   *
   * @param
   *    sem - semester (Eg.: sem1, sem2)
   */
  Future<List<Map<String, dynamic>>> getSubjectList(String collection, String sem) async {
    final data = await _fetch(collection, sem);
    return data?.values.cast<Map<String, dynamic>>().toList() ?? [];
  }

  /*
   * Return map of subject with details.
   *
   * @param
   *    sem - semester (Eg.: sem1, sem2)
   *    subId - Id of the the subject.
   */
  Future<Map<String, dynamic>> getSubjectDetail(String collection, String sem, String subId) async {
    final data =  await getSubjects(collection, sem);
    return data[subId];
  }

  Future<List<Map<String, dynamic>>> getTeacherSubjects(String collection, String id, String ay) async {
    final data = await FirebaseFirestore.instance
        .collection(collection)
        .doc(id)
        .collection(ay)
        .get();

    List<Map<String, dynamic>> subjects = [];

    for (var snapshot in data.docs) {
      final snapshotData = snapshot.data();
      Map<String, dynamic> subjectData = {};

      await (snapshotData['course'] as DocumentReference<Map<String, dynamic>>).get().then((value) {
        subjectData['department'] = value.data()?['department'];
        subjectData['departmentName'] = value.data()?['departmentName'];
        subjectData['course'] = value.data()?['course'];
        subjectData['courseName'] = value.data()?['courseName'];
      });

      await (snapshotData['semRef'] as DocumentReference<Map<String, dynamic>>).get().then((value) async {
        subjectData['title'] = value.data()?[snapshotData['subId']]['title'];

        String? collection = value.data()?[snapshotData['subId']]?['collection'];
        // print(collection);
        if (collection != null) {
          subjectData['doc'] = value.reference.collection(collection);
        }
      });

      subjects.add(subjectData);
    }

    return subjects;
  }
}
