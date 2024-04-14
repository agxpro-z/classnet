import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../models/app_user.dart';
import '../../../services/app_user.dart';
import '../../../services/manager_api.dart';

@lazySingleton
class PreferencesViewModel extends FutureViewModel<void> {
  AppUser? _user;
  final ManagerAPI managerAPI = ManagerAPI();

  Future<void> initialize() async {
    setBusy(true);
    await managerAPI.initialize();
    setBusy(false);
  }

  String? getUserName() => AppUserService().getCurrentUser()?.displayName;
  String? getUserEmail() => AppUserService().getCurrentUser()?.email;

  @override
  Future<void> futureToRun() async {
    if (_user != null) {
      return;
    }
    _user = await AppUserService().getUser();
  }
}