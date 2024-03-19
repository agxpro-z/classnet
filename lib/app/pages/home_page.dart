import 'package:flutter/material.dart';

import '../../res/values/strings.dart';
import '../components/assignment_card.dart';
import '../components/subjects.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              Strings.upcomingAssignments,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: theme.textTheme.titleMedium?.fontSize,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                AssignmentCard(
                  deadline: "Today, 11:59",
                  title: "Assignment 2 & 3",
                  subject: "KE Lab",
                ),
                AssignmentCard(
                  deadline: "Tomorrow, 11:59",
                  title: "Task 1 Tcases",
                  subject: "Software Testing",
                ),
                AssignmentCard(
                  deadline: "Tomorrow, 11:59",
                  title: "Task 1 Tcases",
                  subject: "Software Testing",
                ),
                AssignmentCard(
                  deadline: "Tomorrow, 11:59",
                  title: "Task 1 Tcases",
                  subject: "Software Testing",
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              Strings.notGradedAssignments,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: theme.textTheme.titleMedium?.fontSize,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                AssignmentCard(
                  deadline: "Today, 11:59",
                  title: "Assignment 2 & 3",
                  subject: "KE Lab",
                ),
                AssignmentCard(
                  deadline: "Tomorrow, 11:59",
                  title: "Task 1 Tcases",
                  subject: "Software Testing",
                ),
                AssignmentCard(
                  deadline: "Tomorrow, 11:59",
                  title: "Task 1 Tcases",
                  subject: "Software Testing",
                ),
                AssignmentCard(
                  deadline: "Tomorrow, 11:59",
                  title: "Task 1 Tcases",
                  subject: "Software Testing",
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              Strings.allSubjects,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: theme.textTheme.titleMedium?.fontSize,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          const Subjects(),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
