import 'package:cloud_firestore/cloud_firestore.dart';

/*
 * Provider class for providing details about the ongoing course.
 */
class CourseProvider {
  Future<Map<String, dynamic>?> _fetch() async {
    final data = await FirebaseFirestore.instance
        .collection('mca22')
        .doc('details')
        .get();

    return data.data();
  }

  /*
   * Provides short name of the branch. Eg. MCA.
   */
  Future<String> getBranch() async {
    final data = await _fetch();
    return data?['branch'];
  }

  /*
   * Provides full name of the branch.
   */
  Future<String> getBranchName() async {
    final data = await _fetch();
    return data?['branchName'];
  }

  /*
   * Provides short name of the course. Eg.
   */
  Future<String> getCourse() async {
    final data = await _fetch();
    return data?['course'];
  }

  /*
   * Provides full name of the course.
   */
  Future<String> getCourseName() async {
    final data = await _fetch();
    return data?['courseName'];
  }

  /*
   * Provides list of all the semesters.
   */
  Future<List<String>> getSemList() async {
    final data = await _fetch();
    return data?['sem'].cast<String>();
  }
}
