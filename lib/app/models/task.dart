import 'package:flutter/material.dart';

class Task {
  const Task({
    required this.title,
    required this.time,
  });

  final String title;
  final TimeOfDay time;
}
