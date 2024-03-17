import 'package:flutter/material.dart';

import '../providers/course.dart';
import '../providers/subjects.dart';
import 'subject_card.dart';

class Subjects extends StatefulWidget {
  const Subjects({super.key});

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  List<Map<String, dynamic>> subjectList = [];

  Future<void> updateSubjectList() async {
    final courseProvider = CourseProvider();
    final subjects = await courseProvider.getSemList();

    for (var subject in subjects) {
      if (subject == 'sem4') {
        subjectList = await SubjectsProvider().getSubjectList(subject);
      }
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
              SubjectCard(subject: sub['title'], assignments: 0) // TODO: Update assignment count based on from firebase.
          ],
        );
      },
    );
  }
}
