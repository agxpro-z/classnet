import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'assignment.dart';

@lazySingleton
class Subject {
  const Subject({
    required this.title,
    required this.collectionReference,
  });

  final String title;
  final CollectionReference collectionReference;

  Future<int> contentCount() async {
    final snapshotList = await collectionReference.get();

    bool reduceCount = false;

    for (var snapshot in snapshotList.docs) {
      if (snapshot.id == 'details') {
        reduceCount = true;
        break;
      }
    }

    return reduceCount ? snapshotList.docs.length - 1 : snapshotList.docs.length;
  }

  Future<List<Assignment>> getAssignments() async {
    final snapshotList = await collectionReference.get();
    List<Assignment> list = [];

    for (var snapshot in snapshotList.docs) {
      final data = await snapshot.reference.get();
      final snapshotData = data.data() as Map<String, dynamic>;

      list.add(Assignment(
        title: snapshotData['title'] as String,
        description: snapshotData['description'] as String,
        creator: snapshotData['creator'] as String,
        points: snapshotData['points'] as int,
        createdOn: snapshotData['createdOn'] as DateTime,
      ));
    }

    return list;
  }
}
