import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../res/values/strings.dart';
import '../auth/auth.dart';

class AddAssignment extends StatefulWidget {
  const AddAssignment({
    super.key,
    required this.subjectCollection,
  });

  final CollectionReference<Map<String, dynamic>> subjectCollection;

  @override
  State<AddAssignment> createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  final TextEditingController _assignmentTitleController = TextEditingController();
  final TextEditingController _assignmentDescController = TextEditingController();
  final TextEditingController _assignmentPointController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.addAssignment),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.done_outlined),
            tooltip: Strings.updateAssignment,
            onPressed: () async {
              await widget.subjectCollection.add({
                'points': int.parse(_assignmentPointController.text),
                'title': _assignmentTitleController.text,
                'description': _assignmentDescController.text,
                'creator': Auth.getUserName(),
              });

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(Strings.assignmentPosted),
                      backgroundColor: Colors.yellow[800],
                    )
                );
                Navigator.of(context).pop(context);
              }
            },
          ),
        ],
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
                        controller: _assignmentPointController,
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
                  controller: _assignmentTitleController,
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
                    controller: _assignmentDescController,
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
          )
        ),
      ),
    );
  }
}
