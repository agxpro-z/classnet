// Copyright 2024 agxpro.dev
// Author: Ankit Gourav (agxpro)

import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../models/app_user.dart';
import '../../../services/app_user.dart';
import '../../../services/manager_api.dart';
import '../../../utils/locale.dart';

@lazySingleton
class PreferencesViewModel extends FutureViewModel<void> {
  AppUser? user;
  final bool isStudent = AppUserService().isStudent();
  final ManagerAPI managerAPI = ManagerAPI();
  String languageValue = 'en';

  final LocaleUtil localeUtil = LocaleUtil();

  final List<String> languageList = <String>[
    'en',
    'hi_IN',
    'te_IN',
  ];

  final Map<String, String> language = <String, String>{
    'en': 'English',
    'hi_IN': 'Hindi',
    'te_IN': 'Telugu',
  };

  Future<void> initialize() async {
    setBusy(true);
    await managerAPI.initialize();
    await localeUtil.initialize();
    languageValue = localeUtil.getLocale();
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
