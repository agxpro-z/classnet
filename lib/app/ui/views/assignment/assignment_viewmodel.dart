import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
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

  Future<void> initialize(Assignment assignment) async {
    this.assignment = assignment;
    editing = false;

    assignmentTitleController.text = assignment.title;
    assignmentDescController.text = assignment.description.split('\\n').join('\n');
    assignmentPointController.text = assignment.points.toString();
  }

  void updateAssignment() {
    assignment.title = assignmentTitleController.text;
    assignment.points = int.parse(assignmentPointController.text);
    assignment.description = assignmentDescController.text;

    assignment.update();
  }

  void deleteAssignment() async => await assignment.delete();

  void invertEditing() {
    editing = !editing;
    rebuildUi();
  }
}
