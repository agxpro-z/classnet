import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../models/assignment.dart';
import '../../../models/subject.dart';

@lazySingleton
class AssignmentsViewModel extends BaseViewModel {
  late Subject subject;
  List<Assignment> assignmentList = <Assignment>[];

  Future<void> initialize(Subject sub) async {
    subject = sub;
  }

  Future<void> updateAssignmentList() async {
    assignmentList = await subject.getAssignments();
    print(assignmentList.length);
  }
}
