import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssignmentListTile extends StatelessWidget {
  const AssignmentListTile({super.key, required this.assignmentData});

  final Map<String, dynamic> assignmentData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Container(
              height: 48.0,
              width: 48.0,
              decoration: BoxDecoration(
                color: theme.colorScheme.inversePrimary,
                shape: BoxShape.circle
              ),
              child: const Icon(Icons.assignment_outlined),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(assignmentData['title'],
                    style: TextStyle(
                      fontSize: theme.textTheme.titleSmall?.fontSize,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('HH:mm, dd-MMM-yyyy').format(assignmentData['createdOn']?.toDate() ?? DateTime.now()),
                        style: TextStyle(
                          fontSize: theme.textTheme.bodySmall?.fontSize,
                        ),
                      ),
                      Text(
                        assignmentData['creator'],
                        style: TextStyle(
                          fontSize: theme.textTheme.bodySmall?.fontSize,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
