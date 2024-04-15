import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
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

  Future<void> initialize(Subject subject) async {
    this.subject = subject;

    assignmentTitleController.clear();
    assignmentDescController.clear();
    assignmentPointController.clear();
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
          documentReference: null,
        ),
      );
    } on Exception {
      return false;
    }
    return true;
  }
}