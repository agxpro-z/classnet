import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../models/assignment.dart';
import '../../../models/subject.dart';
import '../../../services/app_user.dart';

@lazySingleton
class AddAssignmentViewModel extends BaseViewModel {
  late Subject subject;
  final isStudent = AppUserService().isStudent();

  final TextEditingController assignmentTitleController = TextEditingController();
  final TextEditingController assignmentDescController = TextEditingController();
  final TextEditingController assignmentPointController = TextEditingController();
  final TextEditingController dueController = TextEditingController();
  DateTime due = DateTime.now().add(const Duration(days: 7));

  Future<void> initialize(BuildContext context, Subject subject) async {
    this.subject = subject;

    assignmentTitleController.clear();
    assignmentDescController.clear();
    assignmentPointController.clear();
    assignmentPointController.text = "100";
    due = DateTime.now().add(const Duration(days: 7));
    updateDue(context);
  }

  void updateDue(BuildContext context) {
    dueController.text = "${TimeOfDay.fromDateTime(due).format(context)}, ${DateFormat('dd-MMM-yyyy').format(due)}";
  }

  Future<bool> addAssignment() async {
    try {
      await subject.addAssignment(
        Assignment(
          title: assignmentTitleController.text,
          description: assignmentDescController.text,
          creator: AppUserService().getCurrentUser()!.displayName!,
          points: int.parse(assignmentPointController.text),
          createdOn: DateTime.now(),
          due: due,
          documentReference: null,
          subject: subject.title,
        ),
      );
    } on Exception {
      return false;
    }
    return true;
  }
}
