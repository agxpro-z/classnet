import 'package:flutter/material.dart';
import 'package:random_gradient_image/random_gradient_image.dart';

import '../../../../i18n/strings.g.dart';

class AssignmentCard extends StatelessWidget {
  const AssignmentCard({
    super.key,
    required this.title,
    required this.subject,
    required this.due,
  });

  final String title;
  final String subject;
  final String due;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              color: theme.colorScheme.primaryContainer,
              margin: const EdgeInsets.all(0.0),
              child: SizedBox(
                height: 144,
                width: 164,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: RandomGradientImage(seed: title + subject, maxSaturation: 0.0001),
                ),
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
            SizedBox(
              width: 164,
              child: Text(
                "${t.widgets.assignments.due}: $due",
                style: TextStyle(
                  fontSize: theme.textTheme.labelMedium?.fontSize,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
