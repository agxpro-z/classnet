import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../../../../res/strings.dart';
import '../home/home_view.dart';
import '../preferences/preferences_view.dart';
import '../schedule/schedule_view.dart';
import '../subjects/subjects_view.dart';

@lazySingleton
class NavigationViewModel extends IndexTrackingViewModel {
  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const SubjectsView();
      case 2:
        return const ScheduleView();
      case 3:
        return const PreferencesView();
      default:
        return const HomeView();
    }
  }

  String getViewName() {
    switch (currentIndex) {
      case 0:
        return Strings.home;
      case 1:
        return Strings.subjects;
      case 2:
        return Strings.schedule;
      case 3:
        return Strings.preferences;
      default:
        return Strings.home;
    }
  }
}
