import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../i18n/strings.g.dart';
import '../../../app.locator.dart';
import '../../../models/subject.dart';
import '../../widgets/shared/custom_sliver_app_bar.dart';
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
      onViewModelReady: (viewModel) => viewModel.initialize(context, widget.subject),
      viewModelBuilder: () => locator<AddAssignmentViewModel>(),
      builder: (BuildContext context, AddAssignmentViewModel viewModel, Widget? child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final bool posted = await viewModel.addAssignment();

            if (context.mounted) {
              if (posted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(t.addAssignmentView.assignmentPosted),
                  backgroundColor: Colors.yellow[800],
                ));
                Navigator.of(context).pop(context);
                widget.parentViewModel.forceUpdateAssignmentList();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(t.addAssignmentView.invalidData),
                  backgroundColor: Colors.red[800],
                ));
              }
            }
          },
          child: const Icon(Icons.done_rounded),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSliverAppBar(
              isMainView: false,
              title: Text(
                t.addAssignmentView.addAssignment,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${t.addAssignmentView.subject}: ',
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      viewModel.subject.title,
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${t.addAssignmentView.title}: ',
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    TextField(
                      controller: viewModel.assignmentTitleController,
                      decoration: InputDecoration(
                        hintText: t.addAssignmentView.titleHint,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          gapPadding: 8.0,
                        ),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '${t.addAssignmentView.points}: ',
                                  style: TextStyle(
                                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              TextField(
                                controller: viewModel.assignmentPointController,
                                decoration: InputDecoration(
                                  hintText: t.addAssignmentView.points,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), gapPadding: 8.0),
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '${t.addAssignmentView.due}: ',
                                  style: TextStyle(
                                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              TextField(
                                onTap: () async {
                                  final DateTime? due = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    initialDate: viewModel.due,
                                    lastDate: DateTime.utc(2099),
                                  );

                                  if (due == null) {
                                    return;
                                  }
                                  if (context.mounted) {
                                    final TimeOfDay? time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(viewModel.due),
                                    );
                                    if (time == null || !context.mounted) {
                                      return;
                                    } else {
                                      viewModel.due = DateTime(
                                        due.year,
                                        due.month,
                                        due.day,
                                        time.hour,
                                        time.minute,
                                      );
                                      viewModel.updateDue(context);
                                    }
                                  }
                                },
                                controller: viewModel.dueController,
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.calendar_month_rounded),
                                  hintText: t.addAssignmentView.dueHint,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    gapPadding: 8.0,
                                  ),
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.none,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${t.addAssignmentView.description}: ',
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Expanded(
                      child: TextField(
                        minLines: 16,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        controller: viewModel.assignmentDescController,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: t.addAssignmentView.descriptionHint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            gapPadding: 8.0,
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
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
