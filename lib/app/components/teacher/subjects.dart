import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../res/values/strings.dart';
import '../../providers/subjects.dart';
import 'subject_card.dart';

class TeacherSubjects extends StatefulWidget {
  const TeacherSubjects({super.key, required this.email, required this.ay});

  final String email;
  final String ay;

  @override
  State<TeacherSubjects> createState() => _TeacherSubjectsState();
}

class _TeacherSubjectsState extends State<TeacherSubjects> {
  List<Map<String, dynamic>> subjectList = [];
  Map<String, int> assignments = {};

  Future<void> updateSubjectList() async {
    subjectList = await SubjectsProvider().getTeacherSubjects('faculty', widget.email.split('@')[0], widget.ay);
    subjectList.sort((a, b) => (a['title'] as String).compareTo(b['title'] as String));

    for (var sub in subjectList) {
      if (sub['doc'] == null) {
        continue;
      }

      await (sub['doc'] as CollectionReference<Map<String, dynamic>>).get().then((snapshot) {
        int count = snapshot.docs.length - 1;
        assignments[sub['title']] = count >= 0 ? count : 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: updateSubjectList(),
      builder: (context, snapshot) {
        return Column(
          children: <Widget>[
            for (var sub in subjectList)
              GestureDetector(
                onTap: () {
                  if (sub['collection'] != null) {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => AssignmentsPage(
                    //     course: widget.course,
                    //     sem: widget.sem,
                    //     subCollection: sub['collection'],
                    //   ),
                    // ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(Strings.noAssignments),
                        backgroundColor: Colors.yellow[800],
                      )
                    );
                  }
                },
                child: TeacherSubjectCard(
                  subject: sub['title'],
                  assignments: assignments[sub['title']] ?? 0,
                  department: sub['department'],
                  course: sub['course'],
                ),
              )
          ],
        );
      },
    );
  }
}
