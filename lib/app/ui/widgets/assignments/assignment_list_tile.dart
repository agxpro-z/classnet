import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/assignment.dart';

class AssignmentListTile extends StatelessWidget {
  const AssignmentListTile({super.key, required this.assignment});

  final Assignment assignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Container(
              height: 48.0,
              width: 48.0,
              decoration: BoxDecoration(color: theme.colorScheme.secondaryContainer, shape: BoxShape.circle),
              child: const Icon(Icons.assignment_outlined),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          assignment.title.toString(),
                          style: TextStyle(
                            fontSize: theme.textTheme.titleMedium?.fontSize,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        assignment.points.toString(),
                        style: TextStyle(
                          fontSize: theme.textTheme.bodyMedium?.fontSize,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Due: ${DateFormat('HH:mm, dd-MMM-yyyy').format(assignment.due ?? DateTime.now())}",
                        style: TextStyle(
                          fontSize: theme.textTheme.bodyMedium?.fontSize,
                        ),
                      ),
                      Text(
                        assignment.creator.toString(),
                        style: TextStyle(
                          fontSize: theme.textTheme.bodyMedium?.fontSize,
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
