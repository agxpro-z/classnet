import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../../../../res/strings.dart';
import '../../../services/auth.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({
    super.key,
    required this.assignmentSnapshot
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> assignmentSnapshot;

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  bool editing = false;
  late Map<String, dynamic> assignment;

  final TextEditingController assignmentTitleController = TextEditingController();
  final TextEditingController assignmentDescController = TextEditingController();
  final TextEditingController assignmentPointController = TextEditingController();

  @override
  void initState() {
    assignment = widget.assignmentSnapshot.data();
    super.initState();
  }

  Future<void> updateAssignment() async {
    await widget.assignmentSnapshot.reference.update(assignment);
    await widget.assignmentSnapshot.reference.get().then((value) {
      if (value.data() != null) {
        assignment = value.data()!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // x();
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (!Auth.getUserEmail().contains('student') && !editing) IconButton(
            icon: const Icon(Icons.edit),
            tooltip: Strings.editAssignment,
            onPressed: () {
              setState(() {
                editing = !editing;
                assignmentTitleController.text = assignment['title']!;
                assignmentDescController.text = (assignment['description'] as String).split('\\n').join('\n');
                assignmentPointController.text = assignment['points'].toString();
              });
            },
          ),
          if (!Auth.getUserEmail().contains('student') && !editing) IconButton(
            icon: const Icon(Icons.delete_outline_outlined),
            tooltip: Strings.deleteAssignment,
            onPressed: () async {
              await widget.assignmentSnapshot.reference.delete();

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(Strings.assignmentDeleted),
                      backgroundColor: Colors.yellow[800],
                    )
                );
                Navigator.of(context).pop(context);
              }
            },
          ),
          if (!Auth.getUserEmail().contains('student') && editing) IconButton(
            icon: const Icon(Icons.done_outlined),
            tooltip: Strings.updateAssignment,
            onPressed: () {
              setState(() {
                editing = !editing;

                assignment['title'] = assignmentTitleController.text;
                assignment['points'] = int.parse(assignmentPointController.text);
                assignment['description'] = assignmentDescController.text;

                updateAssignment();

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(Strings.assignmentUpdated),
                      backgroundColor: Colors.yellow[800],
                    )
                );
              });
            },
          ),
          if (!Auth.getUserEmail().contains('student') && editing) IconButton(
            icon: const Icon(Icons.clear_outlined),
            tooltip: Strings.cancelUpdateAssignment,
            onPressed: () {
              setState(() {
                editing = !editing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: editing ? assignmentEditView(context) : assignmentView()
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  Widget assignmentEditView(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 92,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: assignmentPointController,
                  decoration: InputDecoration(
                    labelText: Strings.points,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        gapPadding: 8.0
                    ),
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        gapPadding: 8.0
                    ),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: assignmentTitleController,
            decoration: InputDecoration(
              labelText: Strings.assignmentTitle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  gapPadding: 8.0
              ),
              isDense: true,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: TextField(
              minLines: 16,
              maxLines: null,
              controller: assignmentDescController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: Strings.assignmentDescription,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    gapPadding: 8.0
                ),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget assignmentView() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          assignment['title'],
          style: TextStyle(
              fontSize: theme.textTheme.titleLarge?.fontSize
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
                  DateFormat('HH:mm, dd-MMM-yyyy').format(assignment['createdOn']?.toDate() ?? DateTime.now()),
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
                      DateFormat('HH:mm, dd-MMM-yyyy').format(assignment['createdOn']
                          ?.toDate() ?? DateTime.now()),
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
                  widget.assignmentSnapshot.data()['creator'],
                ),
                const SizedBox(height: 4.0),
                Text(
                  "${Strings.points}: ${assignment['points'].toString()}",
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
            data: (assignment['description'] as String).split('\\n').join('\n'),
            selectable: true,
          ),
        ),
      ],
    );
  }
}
