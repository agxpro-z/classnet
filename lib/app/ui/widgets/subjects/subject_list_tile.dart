import 'package:flutter/material.dart';

import '../../../../../res/strings.dart';

class SubjectListTile extends StatelessWidget {
  SubjectListTile({
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
  String? department;
  String? course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
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
                    title,
                    style: TextStyle(
                      fontSize: theme.textTheme.titleSmall?.fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (!forStudent)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        "$course ($department)",
                        style: TextStyle(
                          fontSize: theme.textTheme.bodySmall?.fontSize,
                        ),
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
    );
  }
}
