import 'package:flutter/material.dart';

import '../../../../i18n/strings.g.dart';

class AssignmentCard extends StatelessWidget {
  const AssignmentCard({
    super.key,
    required this.deadline,
    required this.title,
    required this.subject,
  });

  final String deadline;
  final String title;
  final String subject;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: theme.colorScheme.primaryContainer,
              margin: const EdgeInsets.all(0.0),
              child: const SizedBox(
                height: 144,
                width: 164,
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: 164,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: theme.textTheme.titleMedium?.fontSize,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 164,
              child: Text(
                subject,
                style: TextStyle(fontSize: theme.textTheme.bodyMedium?.fontSize),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              t.widgets.assignments.deadline + deadline,
              style: TextStyle(fontSize: theme.textTheme.labelMedium?.fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
