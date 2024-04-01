import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../res/values/strings.dart';
import '../components/assignment_list_tile.dart';
import '../providers/assignments.dart';
import 'add_assignment_page.dart';
import 'assignment_page.dart';

class AssignmentsPage extends StatefulWidget {
  const AssignmentsPage({
    super.key,
    required this.course,
    required this.sem,
    required this.subCollection,
    this.assignments,
  });

  final String course;
  final String sem;
  final String subCollection;
  final CollectionReference<Map<String, dynamic>>? assignments;

  @override
  State<AssignmentsPage> createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _assignmentsList = [];

  Future<void> updateAssignmentsList() async {
    if (widget.assignments != null) {
      await widget.assignments?.get().then((snapshot) {
        _assignmentsList = snapshot.docs;
      });
    } else {
      _assignmentsList = await AssignmentsProvider().getRawAssignmentList(widget.course, widget.sem, widget.subCollection);
    }

    _assignmentsList = _assignmentsList.where((snapshot) => snapshot.data()['title'] != null).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.assignments),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          if (widget.assignments == null) {
            return;
          }

          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddAssignment(subjectCollection: widget.assignments!);
          }));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FutureBuilder(
          future: updateAssignmentsList(),
          builder: (context, snapshot) {
            if (_assignmentsList.isEmpty) {
              return const Center(
                child: Text(Strings.noAssignments),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    for (var assignment in _assignmentsList)
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AssignmentPage(assignmentSnapshot: assignment),
                        )),
                        child: AssignmentListTile(assignmentData: assignment.data()),
                      )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
