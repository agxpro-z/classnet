import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class Semester {
  Semester({
    required this.title,
    required this.subList,
    this.documentReference,
  });

  final String title;
  final Map<String, Map<String, String>> subList;
  DocumentReference? documentReference;
}
