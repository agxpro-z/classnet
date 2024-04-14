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

    await managerAPI.initializeCurrentSem();

    await managerAPI.getCurrentSem().getAllSubjects().then((subList) {
      for (var sub in subList) {
        subjectList.add(sub);
      }
    });

    setBusy(false);
  }
}
