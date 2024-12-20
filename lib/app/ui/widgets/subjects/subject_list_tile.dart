import 'package:flutter/material.dart';
import 'package:random_gradient_image/random_gradient_image.dart';

import '../../../../i18n/strings.g.dart';

class SubjectListTile extends StatelessWidget {
  const SubjectListTile({
    super.key,
    required this.title,
    required this.assignments,
    required this.forStudent,
    this.department,
    this.course,
  });

  final String title;
  final int assignments;
  final bool forStudent;
  final String? department;
  final String? course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 48,
              width: 48,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: RandomGradientImage(seed: title, maxSaturation: 0.0001),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: theme.textTheme.titleMedium?.fontSize,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (!forStudent)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Text(
                        "$course ($department)",
                        style: TextStyle(
                          fontSize: theme.textTheme.bodyMedium?.fontSize,
                        ),
                      ),
                    ),
                  Text(
                    "${t.widgets.subjects.assignments}: ${assignments.toString()}",
                    style: TextStyle(
                      fontSize: theme.textTheme.bodySmall?.fontSize,
                    ),
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
