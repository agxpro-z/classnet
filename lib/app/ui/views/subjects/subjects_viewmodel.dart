import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../../res/strings.dart';
import '../../../services/app_user.dart';
import '../../../services/manager_api.dart';
import '../../../models/subject.dart';

@lazySingleton
class SubjectsViewModel extends BaseViewModel {
  final ManagerAPI managerAPI = ManagerAPI();
  final isStudent = AppUserService().isStudent();

  List<String> list = <String>[Strings.semester];
  late String dropDownValue = list.first;
  List<Subject> subjectList = <Subject>[];
  bool primaryRefresh = false;

  final Map<String, String> semName = {
    "sem1": Strings.sem1,
    "sem2": Strings.sem2,
    "sem3": Strings.sem3,
    "sem4": Strings.sem4,
    "sem5": Strings.sem5,
    "sem6": Strings.sem6,
    "sem7": Strings.sem7,
    "sem8": Strings.sem8,
  };

  Future<void> initialize() async {
    if (list.length > 1) {
      return;
    }

    if (isStudent) {
      await managerAPI.initializeCourse();
      final tmpList = managerAPI.getSemList();
      if (tmpList.isNotEmpty) {
        list = tmpList;
        dropDownValue = list.first;
      }
    } else {
      final tmpList = await managerAPI.getAYList();
      if (tmpList.isNotEmpty) {
        list = tmpList;
        dropDownValue = list.first;
      }
    }
  }

  Future<void> updateSubjects(void Function(void Function()) refresh) async {
    subjectList = await managerAPI.getSubjectList(dropDownValue);
    if (!primaryRefresh) {
      refresh(() {});
      primaryRefresh = !primaryRefresh;
    }
  }
}