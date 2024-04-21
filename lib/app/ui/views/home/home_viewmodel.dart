import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../services/app_user.dart';
import '../../../services/manager_api.dart';
import '../../../models/assignment.dart';
import '../../../models/subject.dart';

@lazySingleton
class HomeViewModel extends BaseViewModel {
  final ManagerAPI managerAPI = ManagerAPI();
  final bool isStudent = AppUserService().isStudent();
  final List<Subject> subjectList = <Subject>[];
  final List<Assignment> upcomingAssignmentList = <Assignment>[];
  final List<Assignment> endedAssignmentList = <Assignment>[];

  Future<void> initialize() async {
    setBusy(true);

    if (isStudent) {
      await managerAPI.initializeCurrentSem();
      await managerAPI.getCurrentSem().getAllSubjects().then((subList) async {
        for (var sub in subList) {
          subjectList.add(sub);
          await fetchAssignments(sub);
        }
      });
    } else {
      await managerAPI.initializeCurrentTSem();
      await managerAPI.getTSemester().getSubjects().then((subList) async {
        for (var sub in subList) {
          subjectList.add(sub);
          await fetchAssignments(sub);
        }
      });
    }
    upcomingAssignmentList.sort((a, b) => a.due.compareTo(b.due));

    setBusy(false);
  }

  Future<void> fetchAssignments(Subject sub) async {
    upcomingAssignmentList.addAll((await sub.getAssignments()).where((assignment) {
      final deadline = DateTime.now().add(const Duration(days: 7));
      return assignment.due.compareTo(deadline) <= 0 && assignment.due.compareTo(DateTime.now()) >= 0;
    }));
    endedAssignmentList.addAll((await sub.getAssignments()).where((assignment) {
      final deadline = DateTime.now().subtract(const Duration(days: 8));
      return assignment.due.compareTo(deadline) >= 0 && assignment.due.compareTo(DateTime.now()) <= 0;
    }));
  }
}
