import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../res/values/strings.dart';

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
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.assignmentSnapshot.data()['title'],
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
                        DateFormat('HH:mm, dd-MMM-yyyy').format(widget.assignmentSnapshot.data()['createdOn']?.toDate() ?? DateTime.now()),
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
                            DateFormat('HH:mm, dd-MMM-yyyy').format(widget.assignmentSnapshot.data()['createdOn']
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
                        "${Strings.points}: ${widget.assignmentSnapshot.data()['points'].toString()}",
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  widget.assignmentSnapshot.data()['description']
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
