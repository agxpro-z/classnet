import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../res/strings.dart';
import '../../../app.locator.dart';
import '../../widgets/assignments/assignment_card.dart';
import '../../widgets/shared/custom_sliver_app_bar.dart';
import '../../widgets/subjects/subject_list_tile.dart';
import '../assignments/assignments_view.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelBuilder<HomeViewModel>.reactive(
      disposeViewModel: false,
      fireOnViewModelReadyOnce: true,
      onViewModelReady: (viewModel) => viewModel.initialize(),
      viewModelBuilder: () => locator<HomeViewModel>(),
      builder: (BuildContext context, HomeViewModel viewModel, Widget? child) => Scaffold(
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
                        Strings.subjects,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: theme.textTheme.titleMedium?.fontSize,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    if (viewModel.isBusy)
                      const Center(child: CircularProgressIndicator())
                    else
                      Column(
                        children: <Widget>[
                          for (var sub in viewModel.subjectList)
                            if (viewModel.isStudent)
                              GestureDetector(
                                onTap: () => sub.assignmentCount == 0
                                    ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: const Text(Strings.noAssignments),
                                        backgroundColor: Colors.yellow[800],
                                      ))
                                    : Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => AssignmentsView(
                                          title: sub.title,
                                          subject: sub,
                                        ),
                                      )),
                                child: SubjectListTile(
                                  title: sub.title,
                                  assignments: sub.assignmentCount,
                                  forStudent: viewModel.isStudent,
                                ),
                              )
                            else
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AssignmentsView(
                                    title: sub.title,
                                    subject: sub,
                                  ),
                                )),
                                child: SubjectListTile(
                                  title: sub.title,
                                  assignments: sub.assignmentCount,
                                  forStudent: viewModel.isStudent,
                                  course: sub.courseShort(),
                                  department: sub.departmentShort(),
                                ),
                              ),
                        ],
                      ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
