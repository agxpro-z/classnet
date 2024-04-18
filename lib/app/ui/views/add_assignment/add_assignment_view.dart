import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../res/strings.dart';
import '../../../app.locator.dart';
import '../../../models/subject.dart';
import '../assignments/assignments_viewmodel.dart';
import 'add_assignment_viewmodel.dart';

class AddAssignmentView extends StatefulWidget {
  const AddAssignmentView({
    super.key,
    required this.subject,
    required this.parentViewModel,
  });

  final Subject subject;
  final AssignmentsViewModel parentViewModel;

  @override
  State<AddAssignmentView> createState() => _AddAssignmentViewState();
}

class _AddAssignmentViewState extends State<AddAssignmentView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddAssignmentViewModel>.reactive(
      disposeViewModel: false,
      onViewModelReady: (viewModel) => viewModel.initialize(widget.subject),
      viewModelBuilder: () => locator<AddAssignmentViewModel>(),
      builder: (BuildContext context, AddAssignmentViewModel viewModel, Widget? child) => Scaffold(
        appBar: AppBar(
          title: const Text(Strings.addAssignment),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final bool posted = await viewModel.addAssignment();

            if (context.mounted) {
              if (posted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text(Strings.assignmentPosted),
                  backgroundColor: Colors.yellow[800],
                ));
                Navigator.of(context).pop(context);
                widget.parentViewModel.forceUpdateAssignmentList();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Invalid field data.'),
                  backgroundColor: Colors.red[800],
                ));
              }
            }
          },
          child: const Icon(Icons.done_rounded),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
              child: SizedBox(
            height: MediaQuery.of(context).size.height - 92,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 8.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: viewModel.assignmentPointController,
                        decoration: InputDecoration(
                          labelText: Strings.points,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), gapPadding: 8.0),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: null,
                        decoration: InputDecoration(
                          labelText: 'Due date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            gapPadding: 8.0,
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: viewModel.assignmentTitleController,
                  decoration: InputDecoration(
                    labelText: Strings.assignmentTitle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      gapPadding: 8.0,
                    ),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: TextField(
                    minLines: 16,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: viewModel.assignmentDescController,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: Strings.assignmentDescription,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        gapPadding: 8.0,
                      ),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
