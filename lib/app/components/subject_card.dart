import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    super.key,
    required this.subject,
    required this.upcoming,
    required this.total,
  });

  final String subject;
  final int upcoming;
  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Container(
              height: 64,
              width: 64,
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
                    const SizedBox(height: 8.0),
                    Text(
                      "Upcoming: ${upcoming.toString()}  |  Total: ${total.toString()}",
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
