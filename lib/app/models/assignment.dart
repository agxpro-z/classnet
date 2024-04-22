import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment {
  Assignment({
    required this.title,
    required this.description,
    required this.creator,
    required this.points,
    required this.createdOn,
    required this.due,
    required this.documentReference,
    required this.subject,
  });

  String title;
  String description;
  String creator;
  int points;
  DateTime createdOn;
  DateTime due;
  DocumentReference? documentReference;
  String subject;

  Future<void> update() async {
    await documentReference?.update({
      'title': title,
      'description': description,
      'points': points,
      'due': due,
    });
  }

  Future<void> delete() async {
    await documentReference?.delete();
  }
}
