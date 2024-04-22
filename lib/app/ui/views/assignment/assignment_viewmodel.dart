import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../models/assignment.dart';
import '../../../services/app_user.dart';

@lazySingleton
class AssignmentViewModel extends BaseViewModel {
  late Assignment assignment;
  final isStudent = AppUserService().isStudent();

  bool editing = false;
  final TextEditingController assignmentTitleController = TextEditingController();
  final TextEditingController assignmentDescController = TextEditingController();
  final TextEditingController assignmentPointController = TextEditingController();
  final TextEditingController dueController = TextEditingController();
  DateTime due = DateTime.now().add(const Duration(days: 7));

  Future<void> initialize(Assignment assignment) async {
    this.assignment = assignment;
    editing = false;

    assignmentTitleController.text = assignment.title;
    assignmentDescController.text = assignment.description.split('\\n').join('\n');
    assignmentPointController.text = assignment.points.toString();
    due = assignment.due;
    updateDue();
  }

  void updateDue() {
    dueController.text = DateFormat('HH:mm, dd-MMM-yyyy').format(due);
  }

  bool updateAssignment() {
    assignment.title = assignmentTitleController.text;
    assignment.description = assignmentDescController.text;
    assignment.due = due;

    try {
      assignment.points = int.parse(assignmentPointController.text);
    } on FormatException {
      return false;
    }

    assignment.update();
    return true;
  }

  void deleteAssignment() async => await assignment.delete();

  void invertEditing() {
    editing = !editing;
    rebuildUi();
  }
}
