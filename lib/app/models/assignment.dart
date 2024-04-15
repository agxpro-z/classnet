import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class Assignment {
  Assignment({
    required this.title,
    required this.description,
    required this.creator,
    required this.points,
    required this.createdOn,
    required this.documentReference,
  });

  String title;
  String description;
  String creator;
  int points;
  DateTime createdOn;
  DocumentReference documentReference;

  Future<void> update() async {
    await documentReference.update({
      'title': title,
      'description': description,
      'points': points,
      'creator': creator,
    });
  }

  Future<void> delete() async {
    await documentReference.delete();
  }
}
