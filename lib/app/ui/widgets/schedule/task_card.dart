// Copyright 2024 agxpro.dev
// Author: Ankit Gourav (agxpro)

import 'package:flutter/material.dart';

import '../../../models/task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              task.time.format(context),
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Card(
            elevation: 0.0,
            margin: const EdgeInsets.all(0.0),
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                      ),
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
