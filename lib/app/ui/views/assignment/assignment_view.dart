import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:stacked/stacked.dart';

import '../../../../res/strings.dart';
import '../../../app.locator.dart';
import '../../../models/assignment.dart';
import 'assignment_viewmodel.dart';

class AssignmentView extends StatefulWidget {
  const AssignmentView({
    super.key,
    required this.assignment,
  });

  final Assignment assignment;

  @override
  State<AssignmentView> createState() => _AssignmentViewState();
}

class _AssignmentViewState extends State<AssignmentView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssignmentViewModel>.reactive(
      disposeViewModel: false,
      onViewModelReady: (viewModel) => viewModel.initialize(widget.assignment),
      viewModelBuilder: () => locator<AssignmentViewModel>(),
      builder: (BuildContext context, AssignmentViewModel viewModel, Widget? child) => Scaffold(
        appBar: AppBar(
          actions: [
            if (!viewModel.isStudent && !viewModel.editing)
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: Strings.editAssignment,
                onPressed: () {
                  setState(() {
                    viewModel.editing = !viewModel.editing;
                  });
                },
              ),
            if (!viewModel.isStudent && !viewModel.editing)
              IconButton(
                icon: const Icon(Icons.delete_outline_outlined),
                tooltip: Strings.deleteAssignment,
                onPressed: () {
                  viewModel.deleteAssignment();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(Strings.assignmentDeleted),
                    backgroundColor: Colors.yellow[800],
                  ));
                  Navigator.of(context).pop(context);
                },
              ),
            if (!viewModel.isStudent && viewModel.editing)
              IconButton(
                icon: const Icon(Icons.done_outlined),
                tooltip: Strings.updateAssignment,
                onPressed: () {
                  setState(() {
                    viewModel.editing = !viewModel.editing;
                    viewModel.updateAssignment();

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text(Strings.assignmentUpdated),
                      backgroundColor: Colors.yellow[800],
                    ));
                  });
                },
              ),
            if (!viewModel.isStudent && viewModel.editing)
              IconButton(
                icon: const Icon(Icons.clear_outlined),
                tooltip: Strings.cancelUpdateAssignment,
                onPressed: () {
                  setState(() {
                    viewModel.editing = !viewModel.editing;
                  });
                },
              ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
        children: <Widget>[
          const SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              Expanded(
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
                child: TextField(
                  controller: null,
                  decoration: InputDecoration(
                    labelText: 'Due date',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), gapPadding: 8.0),
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
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), gapPadding: 8.0),
              isDense: true,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: TextField(
              minLines: 16,
              maxLines: null,
              controller: viewModel.assignmentDescController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: Strings.assignmentDescription,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), gapPadding: 8.0),
                isDense: true,
              ),
            ),
          ),
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
          style: TextStyle(fontSize: theme.textTheme.titleLarge?.fontSize),
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
                  DateFormat('HH:mm, dd-MMM-yyyy').format(viewModel.assignment.createdOn ?? DateTime.now()),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: <Widget>[
                    const Text(
                      "${Strings.due}: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      DateFormat('HH:mm, dd-MMM-yyyy').format(viewModel.assignment.createdOn ?? DateTime.now()),
                      style: const TextStyle(
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
                  viewModel.assignment.creator,
                ),
                const SizedBox(height: 4.0),
                Text(
                  "${Strings.points}: ${viewModel.assignment.points.toString()}",
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
          ),
        ),
      ],
    );
  }
}
