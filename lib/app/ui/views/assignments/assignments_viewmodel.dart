import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../models/assignment.dart';
import '../../../models/subject.dart';
import '../../../services/app_user.dart';

@lazySingleton
class AssignmentsViewModel extends BaseViewModel {
  late Subject subject;
  final bool isStudent = AppUserService().isStudent();
  List<Assignment> assignmentList = <Assignment>[];

  Future<void> initialize(Subject sub) async {
    subject = sub;

    await updateAssignmentList();
  }

  Future<void> updateAssignmentList() async {
    setBusy(true);
    assignmentList = await subject.getAssignments();
    setBusy(false);
  }

  @override
  void rebuildUi() {
    updateAssignmentList();
    super.rebuildUi();
  }
}
