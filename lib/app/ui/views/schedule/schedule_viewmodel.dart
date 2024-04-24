// Copyright 2024 agxpro.dev
// Author: Ankit Gourav (agxpro)

import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../models/task.dart';
import '../../../services/app_user.dart';
import '../../../services/manager_api.dart';
import '../../../utils/time_of_day.dart';

@lazySingleton
class ScheduleViewModel extends BaseViewModel {
  final ManagerAPI managerAPI = ManagerAPI();
  final bool isStudent = AppUserService().isStudent();
  List<Task> taskList = <Task>[];
  String taskDay = DateFormat('EEE').format(DateTime.now());
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  Future<void> initialize() async {
    setBusy(true);
    await managerAPI.initialize();
    setBusy(false);

    await fetchScheduleForDay(DateFormat('EEE').format(DateTime.now()));
  }

  Future<void> fetchScheduleForDay(String day) async {
    setBusy(true);

    taskDay = day;

    if (isStudent) {
      taskList = await managerAPI.getCourse().getClassTimeTable(day);
    } else {
      taskList = await managerAPI.getFacultyClassTimeTable(day);
    }
    taskList.sort((a, b) => a.time.compareTo(b.time));

    setBusy(false);
  }
}
