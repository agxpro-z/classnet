// Copyright 2024 agxpro.dev
// Author: Ankit Gourav (agxpro)

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:stacked/stacked.dart';

import '../../../../i18n/strings.g.dart';
import '../../../app.locator.dart';
import '../../../models/assignment.dart';
import 'assignment_viewmodel.dart';

class AssignmentView extends StatefulWidget {
  const AssignmentView({
    super.key,
    required this.assignment,
    required this.parentForceUpdate,
  });

  final Assignment assignment;
  final Future<void> Function() parentForceUpdate;

  @override
  State<AssignmentView> createState() => _AssignmentViewState();
}

class _AssignmentViewState extends State<AssignmentView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssignmentViewModel>.reactive(
      disposeViewModel: false,
      onViewModelReady: (viewModel) => viewModel.initialize(context, widget.assignment),
      viewModelBuilder: () => locator<AssignmentViewModel>(),
      builder: (BuildContext context, AssignmentViewModel viewModel, Widget? child) => Scaffold(
        appBar: AppBar(
          title: Text(viewModel.assignment.subject),
          actions: [
            if (!viewModel.isStudent && !viewModel.editing)
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: t.assignmentView.editAssignment,
                onPressed: () => viewModel.invertEditing(),
              ),
            if (!viewModel.isStudent && !viewModel.editing)
              IconButton(
                icon: const Icon(Icons.delete_outline_outlined),
                tooltip: t.assignmentView.deleteAssignment,
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(t.assignmentView.deleteAssignment),
                    content: Text(t.assignmentView.deleteAssignmentMsg),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(t.cancel),
                      ),
                      FilledButton(
                        onPressed: () {
                          viewModel.deleteAssignment();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(t.assignmentView.assignmentDeleted),
                            backgroundColor: Colors.red[800],
                          ));
                          Navigator.of(context).pop(context);
                          Navigator.of(context).pop(context);
                          widget.parentForceUpdate();
                        },
                        child: Text(t.delete),
                      ),
                    ],
                  ),
                ),
              ),
            if (!viewModel.isStudent && viewModel.editing)
              IconButton(
                icon: const Icon(Icons.done_outlined),
                tooltip: t.assignmentView.updateAssignment,
                onPressed: () {
                  if (viewModel.updateAssignment()) {
                    viewModel.invertEditing();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(t.assignmentView.assignmentUpdated),
                      backgroundColor: Colors.yellow[800],
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(t.assignmentView.invalidData),
                      backgroundColor: Colors.red[800],
                    ));
                  }
                },
              ),
            if (!viewModel.isStudent && viewModel.editing)
              IconButton(
                icon: const Icon(Icons.clear_outlined),
                tooltip: t.cancel,
                onPressed: () => viewModel.invertEditing(),
              ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
              child: viewModel.editing ? assignmentEditView(context, viewModel) : assignmentView(viewModel)),
        ),
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  Widget assignmentEditView(BuildContext context, AssignmentViewModel viewModel) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 92,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              '${t.assignmentView.title}: ',
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
              hintText: t.assignmentView.titleHint,
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
                        '${t.assignmentView.points}: ',
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
                        hintText: t.assignmentView.points,
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
                        '${t.assignmentView.due}: ',
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
                        hintText: t.assignmentView.dueHint,
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
              '${t.assignmentView.description}: ',
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
                hintText: t.assignmentView.descriptionHint,
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
    );
  }

  Widget assignmentView(AssignmentViewModel viewModel) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          viewModel.assignment.title,
          style: TextStyle(
            fontSize: theme.textTheme.titleLarge?.fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  DateFormat('HH:mm, dd-MMM-yyyy').format(viewModel.assignment.createdOn),
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "${t.assignmentView.due}: ",
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      DateFormat('HH:mm, dd-MMM-yyyy').format(viewModel.assignment.due),
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "${t.assignmentView.points}: ${viewModel.assignment.points.toString()}",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  viewModel.assignment.creator,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: MarkdownBlock(
            data: viewModel.assignment.description.split('\\n').join('\n'),
            selectable: true,
            config: Theme.of(context).brightness == Brightness.dark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig,
          ),
        ),
      ],
    );
  }
}
