import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../res/strings.dart';
import '../../../app.locator.dart';
import '../../../models/subject.dart';
import '../../widgets/assignments/assignment_list_tile.dart';
import '../../widgets/shared/custom_sliver_app_bar.dart';
import '../assignment/assignment_view.dart';
import 'assignments_viewmodel.dart';

class AssignmentsView extends StatefulWidget {
  const AssignmentsView({
    super.key,
    required this.title,
    required this.subject,
  });

  final String title;
  final Subject subject;

  @override
  State<AssignmentsView> createState() => _AssignmentsViewState();
}

class _AssignmentsViewState extends State<AssignmentsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssignmentsViewModel>.reactive(
      disposeViewModel: false,
      onViewModelReady: (viewMode) => viewMode.initialize(widget.subject),
      viewModelBuilder: () => locator<AssignmentsViewModel>(),
      builder: (BuildContext context, AssignmentsViewModel viewModel, Widget? child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            //   return AddAssignment(subjectCollection: widget.assignments!);
            // }));
          },
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSliverAppBar(
              isMainView: false,
              title: Text(
                Strings.assignments,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: FutureBuilder(
                  future: viewModel.updateAssignmentList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (viewModel.assignmentList.isEmpty) {
                      return const Center(
                        child: Text(Strings.noAssignments),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            for (var assignment in viewModel.assignmentList)
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AssignmentView(assignment: assignment),
                                )),
                                child: AssignmentListTile(assignment: assignment),
                              )
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
