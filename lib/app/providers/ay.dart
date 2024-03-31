
import 'package:cloud_firestore/cloud_firestore.dart';

class AYProvider {
  Future<List<String>> getAYList(String collection, String teacherId) async {
    final data = await FirebaseFirestore.instance
        .collection(collection)
        .doc(teacherId)
        .get();

    return data.data()?['ay'].cast<String>();
  }
}
