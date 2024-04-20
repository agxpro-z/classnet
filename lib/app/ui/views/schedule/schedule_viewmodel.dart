import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../models/task.dart';
import '../../../services/app_user.dart';
import '../../../services/manager_api.dart';

@lazySingleton
class ScheduleViewModel extends BaseViewModel {
  final ManagerAPI managerAPI = ManagerAPI();
  List<Task> taskList = <Task>[];
  final bool isStudent = AppUserService().isStudent();

  Future<void> initialize() async {
    setBusy(true);

    if (isStudent) {
      await managerAPI.initialize();
      taskList = await managerAPI.getCourse().getClassTimeTable(DateFormat('EEE').format(DateTime.now()));
    } else {
      taskList = await managerAPI.getFacultyClassTimeTable(DateFormat('EEE').format(DateTime.now()));
      taskList.sort((a, b) => a.time.toString().compareTo(b.time.toString()));
    }

    setBusy(false);
  }
}
