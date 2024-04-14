import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../services/app_user.dart';
import '../../../services/manager_api.dart';
import '../../../models/subject.dart';

@lazySingleton
class HomeViewModel extends BaseViewModel {
  final ManagerAPI managerAPI = ManagerAPI();
  final List<Subject> subjectList = <Subject>[];
  final bool isStudent = AppUserService().isStudent();

  Future<void> initialize() async {
    setBusy(true);

    if (isStudent) {
      await managerAPI.initializeCurrentSem();
      await managerAPI.getCurrentSem().getAllSubjects().then((subList) {
        for (var sub in subList) {
          subjectList.add(sub);
        }
      });
    } else {
      await managerAPI.initializeCurrentTSem();
      await managerAPI.getTSemester().getSubjects().then((subList) {
        for (var sub in subList) {
          subjectList.add(sub);
        }
      });
    }

    setBusy(false);
  }
}
