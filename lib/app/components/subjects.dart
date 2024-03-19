import 'package:classnet/app/pages/assignments_page.dart';
import 'package:classnet/app/providers/assignments.dart';
import 'package:flutter/material.dart';

import '../providers/subjects.dart';
import 'subject_card.dart';

class Subjects extends StatefulWidget {
  const Subjects({super.key, required this.course, required this.sem});

  final String course;
  final String sem;

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  List<Map<String, dynamic>> subjectList = [];
  Map<String, int> assignments = {};

  Future<void> updateSubjectList() async {
    subjectList = await SubjectsProvider().getSubjectList(widget.course, widget.sem);
    subjectList.sort((a, b) => (a['title'] as String).compareTo(b['title'] as String));

    for (var sub in subjectList) {
      if (sub['collection'] == null) {
        continue;
      }

      assignments[sub['title']] = await SubjectsProvider().getAssignmentCount(widget.course, 'sem4', sub['collection']);
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AssignmentsPage(
                        course: widget.course,
                        sem: widget.sem,
                        subCollection: sub['collection'],
                      ),
                    ));
                  }
                },
                child: SubjectCard(subject: sub['title'], assignments: assignments[sub['title']] ?? 0),
              )
          ],
        );
      },
    );
  }
}
