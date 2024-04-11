import 'package:flutter/material.dart';

import '../../res/strings.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    super.key,
    required this.subject,
    required this.assignments,
  });

  final String subject;
  final int assignments;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: theme.colorScheme.primaryContainer,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 104,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      subject,
                      style: TextStyle(
                        fontSize: theme.textTheme.titleSmall?.fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${Strings.assignments}: ${assignments.toString()}",
                      style: TextStyle(
                        fontSize: theme.textTheme.bodySmall?.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
