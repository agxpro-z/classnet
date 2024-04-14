import 'package:flutter/material.dart';

import '../../../../res/strings.dart';
import '../../../services/auth.dart';
import '../../widgets/assignments/assignment_card.dart';
import '../../widgets/shared/custom_sliver_app_bar.dart';
import '../../widgets/subjects/subjects.dart';
import '../../widgets/subjects/teacher_subjects.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Widget subjects() {
    String email = Auth.getUserEmail();

    if (email.contains('student')) {
      return const Subjects(course: 'mca22', sem: 'sem4');
    } else {
      return TeacherSubjects(email: email, ay: 'AY2324-I');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            isMainView: true,
            title: Text(
              Strings.home,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed(
                <Widget>[
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
                  subjects(),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
