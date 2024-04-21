import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../models/app_user.dart';
import '../../../services/app_user.dart';
import '../../../services/manager_api.dart';

@lazySingleton
class PreferencesViewModel extends FutureViewModel<void> {
  AppUser? user;
  final bool isStudent = AppUserService().isStudent();
  final ManagerAPI managerAPI = ManagerAPI();

  Future<void> initialize() async {
    setBusy(true);
    await managerAPI.initialize();
    await futureToRun();
    setBusy(false);
  }

  String? getUserName() => AppUserService().getCurrentUser()?.displayName;
  String? getUserEmail() => AppUserService().getCurrentUser()?.email;

  @override
  Future<void> futureToRun() async {
    if (user != null) {
      return;
    }
    user = await AppUserService().getUser();
  }
}
